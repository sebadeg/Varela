class PrincipalController < ApplicationController

  def index
    @usuario = Usuario.new()
    @actividad = ActividadAlumno.new()

    if usuario_signed_in?
      @alumnos = Alumno.where([
        "id IN (SELECT cuenta_alumnos.alumno_id FROM ( cuentas INNER JOIN titular_cuentas ON cuentas.id=titular_cuentas.cuenta_id ) INNER JOIN cuenta_alumnos ON cuentas.id=cuenta_alumnos.cuenta_id WHERE titular_cuentas.usuario_id=?)" +
        " OR " +
        "id IN (SELECT padre_alumnos.alumno_id FROM padre_alumnos WHERE padre_alumnos.usuario_id=?)",
        current_usuario.id, current_usuario.id]).order(:nombre)
    else
      @alumnos = nil
    end
  end

    def download_pdf
    send_file(
      "#{Rails.root}/data/Carta Familias 1o Secundaria Campamento 2018.pdf",
      filename: "Carta Familias 1o Secundaria Campamento 2018.pdf",
      type: "application/pdf"
    )
  end

  def autorizar
    p ""
    p params[:actividad_alumno][:alumno_id]
    p params[:actividad_alumno][:opcion]
    p ""
    p ""    

    actividad_alumno = ActividadAlumno.where( ["alumno_id = ? AND actividad_id = ?", params[:actividad_alumno][:alumno_id], params[:actividad_alumno][:actividad_id]]).first rescue nil

    if ( actividad_alumno != nil )
      actividad_alumno.opcion = params[:actividad_alumno][:opcion]
      actividad_alumno.save!()
    end
    redirect_to root_path
  end

  require 'digest/md5'
  
  def digito(cedula)
    if ( cedula == nil )      
      return false
    end
    suma = 0
    arr = [4,3,6,7,8,9,2]
    digit = cedula%10 
    c = cedula/10
    (0..6).each do |i|
       r = c%10
       c = c/10
       suma = (suma + r*arr[i]) % 10
    end
    return (digit == ((10-(suma%10))%10))
  end

  def asociar
    if ( !digito(params[:usuario][:cedula].to_i) )
      p "Error en cedula"
      return
    end

    @usuario = Usuario.where( ["cedula = ?", params[:usuario][:cedula]]).first rescue nil
    if ( @usuario != nil )
      password =  Digest::MD5.hexdigest(params[:usuario][:cedula] + DateTime.now.strftime('%Y%m%d%H%M%S'))[0..7]
      p password
      @usuario.update( password: password, password_confirmation: password );
      if ( params[:usuario][:alumno2] == "1")
        TitularCuenta.create(usuario_id: @usuario.id, cuenta_id: params[:usuario][:alumno1].to_i)
      else
        CuentaAlumno.where( ["cuenta_id = ?", params[:usuario][:alumno1].to_i ]).each do |e|
          PadreAlumno.create(usuario_id: @usuario.id, alumno_id: e.alumno_id )
        end
      end
    end        
    redirect_to root_path
  end
end
