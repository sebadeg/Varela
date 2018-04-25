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


  def asociar
    @usuario = Usuario.where( ["cedula = ?", params[:usuario][:cedula]]).first rescue nil
    if ( @usuario != nil )
      @usuario.update( password: params[:usuario][:password], password_confirmation: params[:usuario][:password] );
      ActiveRecord::Base.connection.execute("UPDATE usuarios SET cedula=" + params[:usuario][:cedula].to_s + " WHERE id=" + @usuario.id.to_s + ";")

      TitularCuenta.create(usuario_id: @usuario.id, cuenta_id: params[:usuario][:alumno1].to_i)
      #PadreAlumno.create(usuario_id: @usuario.id, alumno_id: params[:usuario][:alumno1].to_i)
    end
  end
end
