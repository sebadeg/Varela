class PrincipalController < ApplicationController

  $movimientosnuevos

  def eventos
    @evento_usuario = EventoUsuario.new()
  end

  def eventos_registrar

    evento_usuario = EventoUsuario.new(
          nombres: params[:evento_usuario][:nombres], 
          apellidos: params[:evento_usuario][:apellidos], 
          telefono: params[:evento_usuario][:telefono], 
          celular: params[:evento_usuario][:celular], 
          direccion: params[:evento_usuario][:direccion], 
          nacimiento: params[:evento_usuario][:nacimiento], 
          nacionalidad: params[:evento_usuario][:nacionalidad],
          email: params[:evento_usuario][:email], 
          horarios: params[:evento_usuario][:horarios], 
          universidad_completa: params[:evento_usuario][:universidad_completa], 
          universidad_incompleta: params[:evento_usuario][:universidad_incompleta], 
          trabajo: params[:evento_usuario][:trabajo], 
          ultimo_trabajo: params[:evento_usuario][:ultimo_trabajo], 
          comentarios: params[:evento_usuario][:comentarios] 
          )
    evento_usuario.save!

    UserMailer.eventos_usuario(evento_usuario).deliver_now

    redirect_to principal_eventos_registrado_path
  end

  def eventos_registrado

  end

  def index



    @x = Actividad.new()
    @y = ActividadAlumno.new()
    @usuario = Usuario.new()
    @actividad = ActividadAlumno.new()

    @cuenta = Cuenta.new()

    if usuario_signed_in?

      usuario = current_usuario.id 
      @alumnos = Alumno.where([
        "id IN (SELECT cuenta_alumnos.alumno_id FROM ( cuentas INNER JOIN titular_cuentas ON cuentas.id=titular_cuentas.cuenta_id ) INNER JOIN cuenta_alumnos ON cuentas.id=cuenta_alumnos.cuenta_id WHERE titular_cuentas.usuario_id=?)" +
        " OR " +
        "id IN (SELECT padre_alumnos.alumno_id FROM padre_alumnos WHERE padre_alumnos.usuario_id=?)",
        usuario, usuario]).order(:nombre)

      @cuentas = Cuenta.where(["id IN (SELECT cuenta_id FROM titular_cuentas WHERE usuario_id = ?)", usuario])
      #@cuentas = Cuenta.where("id IN (SELECT DISTINCT cuenta FROM usuarios)").order(:id)
      #@cuentas = Cuenta.where(["id = ?",12338])

      #File.open(Rails.root.join("data", 'movimientos.txt'),'w') do |f|          
        @movimientos = Array.new
        @cuentas.each do |cuenta|
          movs = Movimiento.where(["cuenta_id = ? AND not pendiente", cuenta.id]).order(:fecha,:tipo,:alumno,:descripcion)
          @movimientos.push( [cuenta.id, movs ] )
    
          # saldo = 0
          # movs.each do |m|
          #   saldo = saldo + m.debe - m.haber
          #   f.puts m.cuenta_id.to_s + ";" + m.alumno.to_s + ";" + m.fecha.to_s + ";" + m.descripcion + ";" + m.extra + ";" + m.debe.to_s + ";" + m.haber.to_s + ";" + saldo.to_s
          # end
          #f.puts ""
        end
      #end

        if current_usuario.cedula == 16 
          @noregistrado = Alumno.where("id NOT IN (SELECT cuenta_alumnos.alumno_id FROM cuenta_alumnos INNER JOIN titular_cuentas ON cuenta_alumnos.cuenta_id=titular_cuentas.cuenta_id) AND id IN (SELECT alumno_id FROM actividad_alumnos)").order(:nombre)
          @van = Alumno.where("id IN (SELECT cuenta_alumnos.alumno_id FROM cuenta_alumnos INNER JOIN titular_cuentas ON cuenta_alumnos.cuenta_id=titular_cuentas.cuenta_id) AND id IN (SELECT alumno_id FROM actividad_alumnos WHERE opcion=1 OR opcion=2)").order(:nombre)
          @novan = Alumno.where("id IN (SELECT cuenta_alumnos.alumno_id FROM cuenta_alumnos INNER JOIN titular_cuentas ON cuenta_alumnos.cuenta_id=titular_cuentas.cuenta_id) AND id IN (SELECT alumno_id FROM actividad_alumnos WHERE opcion=0)").order(:nombre)
          @noeligio = Alumno.where("id IN (SELECT cuenta_alumnos.alumno_id FROM cuenta_alumnos INNER JOIN titular_cuentas ON cuenta_alumnos.cuenta_id=titular_cuentas.cuenta_id) AND id IN (SELECT alumno_id FROM actividad_alumnos WHERE opcion IS NULL)").order(:nombre)
        elsif current_usuario.cedula == 19873943  
          @van = Alumno.where("id IN (SELECT cuenta_alumnos.alumno_id FROM cuenta_alumnos INNER JOIN titular_cuentas ON cuenta_alumnos.cuenta_id=titular_cuentas.cuenta_id) AND id IN (SELECT alumno_id FROM actividad_alumnos WHERE actividad_id=3 AND opcion=1)").order(:nombre)
        end
    else
      @alumnos = nil
    end
  end

  def download_pdf

    p params[:actividad][:id]

    actividad = Actividad.find(params[:actividad][:id])    
    if ( actividad != nil )
      file = Tempfile.new("actividad.pdf")
      IO.binwrite(file.path, actividad.data)

      send_file(
        file.path,
        filename: actividad.archivo,
        type: "application/pdf"
      )

    else
      redirect_to root_path
    end
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
      # if ( params[:usuario][:alumno2] == "1")
      #   TitularCuenta.create(usuario_id: @usuario.id, cuenta_id: params[:usuario][:alumno1].to_i)
      # else
      #   CuentaAlumno.where( ["cuenta_id = ?", params[:usuario][:alumno1].to_i ]).each do |e|
      #     PadreAlumno.create(usuario_id: @usuario.id, alumno_id: e.alumno_id )
      #   end
      # end
    end        
    redirect_to root_path
  end

  def cambiar
    #cuentas = Cuenta.where("id IN (SELECT DISTINCT cuenta_id FROM movimientos WHERE NOT valido AND NOT duda AND descripcion LIKE 'Cuota %')")

    # cuentas = Cuenta.all
    # cuentas.each do |cuenta|
    #   (1..5).each do |alumno|
    #     movs = Movimiento.where(["cuenta_id = ? AND alumno = ? AND descripcion LIKE 'Cuota%/%'", cuenta.id, alumno]).order(:fecha)
    #     c = 1
    #     movs.each do |mov|
    #       mov.descripcion = 'Cuota ' + c.to_s + '/' + movs.count.to_s
    #       mov.save!
    #       c = c + 1
    #     end

    #     movs = Movimiento.where(["cuenta_id = ? AND alumno = ? AND descripcion LIKE 'Descuento%/%'", cuenta.id, alumno]).order(:fecha)
    #     c = 1
    #     movs.each do |mov|
    #       mov.descripcion = 'Descuento ' + c.to_s + '/' + movs.count.to_s
    #       mov.save!
    #       c = c + 1
    #     end
    #   end
    # end

    # (1..12).each do |mes|
    #   p mes

    #   m = Movimiento.new()
    #   m.cuenta_id = 13917
    #   m.alumno = 1
    #   m.fecha = DateTime.new(2018,mes,1,0,0,0)
    #   m.descripcion = 'Cuota ' + mes.to_s + "/12"
    #   m.extra = 0
    #   m.debe = 9200
    #   m.haber = 0
    #   m.tipo = 2 
    #   m.pendiente = ( m.fecha < DateTime.new(2018,6,1,0,0,0) )
    #   m.valido = false    
    #   m.duda = false
    #   m.save!

    #   m = Movimiento.new()
    #   m.cuenta_id = 13917
    #   m.alumno = 1
    #   m.fecha = DateTime.new(2018,mes,1,0,0,0)
    #   m.descripcion = 'Descuento ' + mes.to_s + "/12"
    #   m.extra = 0
    #   if ( m.fecha < DateTime.new(2018,6,1,0,0,0) )
    #     m.debe = -9200
    #   else
    #     m.debe = -272
    #   end
    #   m.haber = 0
    #   m.tipo = 3 
    #   m.pendiente = ( m.fecha < DateTime.new(2018,6,1,0,0,0) )
    #   m.valido = false    
    #   m.duda = false
    #   m.save!
    # end

    # (225..235).each do |num|
    #   usuario = Usuario.find(num)
    #   if ( usuario != nil  && usuario.validado && ( usuario.mail == nil || !usuario.mail ) )
    #     p usuario.passwd

    #     usuario.mail = true
    #     usuario.save

    #     usuario.update( password: usuario.passwd, password_confirmation: usuario.passwd );
    #     if ( usuario.titular )
    #       TitularCuenta.create(usuario_id: usuario.id, cuenta_id: usuario.cuenta)
    #     else
    #       CuentaAlumno.where( ["cuenta_id = ?", usuario.cuenta ]).each do |e|
    #         PadreAlumno.create(usuario_id: usuario.id, alumno_id: e.alumno_id )
    #       end
    #     end
    #     UserMailer.aceptar_usuario(usuario).deliver_now
    #   end 
    # end     
    redirect_to root_path
  end


  def duda
    ActiveRecord::Base.connection.execute( "UPDATE movimientos SET duda=true WHERE cuenta_id = #{params[:cuenta][:id]}" )
    redirect_to root_path
  end




  def movimientos
    @movimientos = Movimiento.where(["cuenta_id = ?", params[:cuenta][:id]]).order(:fecha,:tipo,:alumno,:descripcion)
  end

  def cuentas
    if usuario_signed_in?
      @cuenta_id = params[:cuenta][:id]
      
      @alumnos = Alumno.where([
        "id IN (SELECT cuenta_alumnos.alumno_id FROM ( cuentas INNER JOIN titular_cuentas ON cuentas.id=titular_cuentas.cuenta_id ) INNER JOIN cuenta_alumnos ON cuentas.id=cuenta_alumnos.cuenta_id WHERE titular_cuentas.cuenta_id=?)",
        @cuenta_id]).order(:nombre)

      @movimientos = Movimiento.where(["cuenta_id = ? AND not pendiente", @cuenta_id]).order(:fecha,:tipo,:alumno,:descripcion)

    end


  end


  def movimientoupdate
    mov = Movimiento.find(params[:movimiento][:id])
    cuenta_id = mov.cuenta_id

    mov.update( 
      alumno: params[:movimiento][:alumno], 
      tipo: params[:movimiento][:tipo], 
      descripcion: params[:movimiento][:descripcion], 
      debe: params[:movimiento][:debe], 
      haber: params[:movimiento][:haber])

    #cuenta = Cuenta.find(cuenta_id)
    redirect_to root_path
  end

  def movimientoborrar
    mov = Movimiento.find(params[:movimiento][:id])
    cuenta_id = mov.cuenta_id

    ActiveRecord::Base.connection.execute( "DELETE FROM movimientos WHERE id = #{params[:movimiento][:id]}" )

    #cuenta = Cuenta.find(cuenta_id)
    redirect_to root_path
  end

  def movimientofin
    ActiveRecord::Base.connection.execute( "UPDATE movimientos SET valido=true WHERE cuenta_id = #{params[:movimiento][:cuenta_id]}" )

    redirect_to root_path
  end


  def cargarmovimientos

    $movimientosnuevos = ""
    lines = File.readlines(params[:archivo].path, encoding: 'ISO-8859-1')
    lines.each do |line|
      ss = line.split(";")
      m = Movimiento.new()
      m.cuenta_id = ss[0].to_i
      m.alumno = ss[1].to_i
      m.fecha = DateTime.strptime(ss[2], "%d/%m/%Y")
      m.descripcion = ss[3]
      m.extra = ss[4]
      m.tipo = ss[5].to_i
      m.debe = ss[6].to_f
      m.haber = ss[7].to_f
      m.save
    end
    redirect_to root_path
  end



  def registro
    #Usuario.where( "(mail IS NULL OR NOT mail) AND validado AND passwd IS NULL" ).each do |u|
    #  u.update(passwd: Digest::MD5.hexdigest(u.cedula.to_s + DateTime.now.strftime('%Y%m%d%H%M%S'))[0..7] )      
    #end


    @usuarios = Usuario.where('(mail IS NULL OR NOT mail) AND (validado IS NULL OR NOT validado)').order(:cedula)
    @usuariosmail = Usuario.where('(mail IS NULL OR NOT mail) AND validado').order(:cedula)
  end

  def validarregistro
    usuario = Usuario.find(params[:usuario][:id])
    usuario.update( 
      cuenta: params[:usuario][:cuenta], 
      titular: params[:usuario][:titular],
      validado: true,
      passwd: Digest::MD5.hexdigest(params[:usuario][:cedula] + DateTime.now.strftime('%Y%m%d%H%M%S'))[0..7])
    redirect_to principal_registro_path
  end

  def enviarpassword
    usuario = Usuario.find(params[:usuario][:id])
    if ( usuario != nil  && usuario.validado && ( usuario.mail == nil || !usuario.mail ) )
      p usuario.passwd

      usuario.mail = true
      usuario.save

      usuario.update( password: usuario.passwd, password_confirmation: usuario.passwd );
      if ( usuario.titular )
        TitularCuenta.create(usuario_id: usuario.id, cuenta_id: usuario.cuenta)
      else
        CuentaAlumno.where( ["cuenta_id = ?", usuario.cuenta ]).each do |e|
          PadreAlumno.create(usuario_id: usuario.id, alumno_id: e.alumno_id )
        end
      end
      UserMailer.aceptar_usuario(usuario).deliver_now
    end 
    redirect_to principal_registro_path
  end


  def download_factura

    p params[:cuenta][:id]

    cuenta_id = params[:cuenta][:id]

    factura = Factura.where("cuenta_id=#{cuenta_id}").order(fecha: :desc).first rescue nil
    if factura != nil

      file = Tempfile.new("factura.pdf")

      factura.imprimir(file.path,cuenta_id,factura)
      

      send_file(
        file.path,
        filename: "factura_#{cuenta_id}_#{factura.id}.pdf",
        type: "application/pdf"
      )

    else
      redirect_to principal_index_path
    end
  end

  # def imprimirfactura
    
  #   Factura.find(id).imprimir()

  #   output_file = Rails.root.join("tmp", 'output.pdf')
  #   send_file(output_file, filename: "output.pdf", type: "application/pdf")
    
  # end

  def calc_cedula_digit(cedula)
    if cedula == nil || cedula == ""
      return false
    end
    cedula = cedula.to_i
    suma = 0
    arr = [4,3,6,7,8,9,2]
    digit = cedula%10 
    c = cedula/10
    (0..6).each do |i|
       r = c%10
       c = c/10
       suma = (suma + r*arr[i]) % 10
    end
    return digit == ((10-(suma%10))%10)
  end

  def inscribir

    p "Inscribir"

    id = params[:inscripcionAlumno][:id]
    inscripcionAlumno = InscripcionAlumno.find(id)

    if inscripcionAlumno.registrado 
      redirect_to principal_index_path, alert: "El alumno ya está reinscripto"
      return
    end

    alerta = ""

    inscripcionAlumno.registrado = true
    if calc_cedula_digit(params[:inscripcionAlumno][:cedula])
      inscripcionAlumno.cedula = params[:inscripcionAlumno][:cedula]
    else
      alerta = alerta + "Cédula de alumno incorrecta. " 
      inscripcionAlumno.cedula = nil
      inscripcionAlumno.registrado = false
    end
    inscripcionAlumno.grado = params[:inscripcionAlumno][:grado]
    inscripcionAlumno.convenio_id = params[:inscripcionAlumno][:convenio_id]
    inscripcionAlumno.cuotas = params[:inscripcionAlumno][:cuotas]
    inscripcionAlumno.hermanos = params[:inscripcionAlumno][:hermanos]
    inscripcionAlumno.visa = params[:inscripcionAlumno][:visa]
    inscripcionAlumno.matricula = params[:inscripcionAlumno][:matricula]

    if params[:inscripcionAlumno][:nombre1] != nil && params[:inscripcionAlumno][:nombre1] != ""
      inscripcionAlumno.nombre1 = params[:inscripcionAlumno][:nombre1]
    else
      alerta = alerta + "Nombre de titular 1 vacío. " 
      inscripcionAlumno.nombre1 = nil
      inscripcionAlumno.registrado = false
    end

    if calc_cedula_digit(params[:inscripcionAlumno][:documento1])
      inscripcionAlumno.documento1 = params[:inscripcionAlumno][:documento1]
    else
      alerta = alerta + "Cédula de titular 1 incorrecta. " 
      inscripcionAlumno.documento1 = nil
      inscripcionAlumno.registrado = false
    end

    if params[:inscripcionAlumno][:domicilio1] != nil && params[:inscripcionAlumno][:domicilio1] != ""
      inscripcionAlumno.domicilio1 = params[:inscripcionAlumno][:domicilio1]
    else
      alerta = alerta + "Domicilio de titular 1 vacío. " 
      inscripcionAlumno.domicilio1 = nil
      inscripcionAlumno.registrado = false
    end

    if params[:inscripcionAlumno][:celular1] != nil && params[:inscripcionAlumno][:celular1] != ""
      inscripcionAlumno.celular1 = params[:inscripcionAlumno][:celular1]
    else
      alerta = alerta + "Celular de titular 1 vacío. " 
      inscripcionAlumno.celular1 = nil
      inscripcionAlumno.registrado = false
    end

    if params[:inscripcionAlumno][:email1] != nil && params[:inscripcionAlumno][:email1] != ""
      inscripcionAlumno.email1 = params[:inscripcionAlumno][:email1]
    else
      alerta = alerta + "Mail de titular 1 vacío. " 
      inscripcionAlumno.email1 = nil
      inscripcionAlumno.registrado = false
    end

    inscripcionAlumno.nombre2 = params[:inscripcionAlumno][:nombre2]
    if params[:inscripcionAlumno][:documento2] != nil && params[:inscripcionAlumno][:documento2] != ""
      if calc_cedula_digit(params[:inscripcionAlumno][:documento2])
        inscripcionAlumno.documento2 = params[:inscripcionAlumno][:documento2]
      else
        inscripcionAlumno.documento2 = nil
        inscripcionAlumno.registrado = false
      end
    else
      inscripcionAlumno.documento2 = nil
    end
    inscripcionAlumno.domicilio2 = params[:inscripcionAlumno][:domicilio2]
    inscripcionAlumno.celular2 = params[:inscripcionAlumno][:celular2]
    inscripcionAlumno.email2 = params[:inscripcionAlumno][:email2]

    inscripcionAlumno.save!

    if !inscripcionAlumno.registrado
      redirect_to principal_index_path, alert: alerta
      return
    end

    if inscripcionAlumno.cuotas == 0 
      redirect_to principal_index_path, notice: "Ha comenzado el proceso de reinscripción"
    else
      factura = Factura.all.first

      file_name = "reinscripcion_#{inscripcionAlumno.alumno_id}.pdf"
      file = Tempfile.new("factura.pdf")
      factura.vale(file.path,id)

      UserMailer.reinscripcion(inscripcionAlumno,file_name,file).deliver_now

      send_file(
          file.path,
          filename: file_name,
          type: "application/pdf"
        )
    end
  end

  def download_inscripcion

    id = params[:inscripcionAlumno][:id]
    inscripcionAlumno = InscripcionAlumno.find(id)

    factura = Factura.all.first

    file_name = "reinscripcion_#{inscripcionAlumno.alumno_id}.pdf"
    file = Tempfile.new("factura.pdf")
    factura.vale(file.path,id)

    send_file(
        file.path,
        filename: file_name,
        type: "application/pdf"
      )
  end

  def download_ayuda

    id = params[:inscripcionAlumno][:id]
    inscripcionAlumno = InscripcionAlumno.find(id)

    send_file(
        Rails.root.join("data", "Instructivo reinscripción.pdf"),  
        filename: "Instructivo reinscripción.pdf",
        type: "application/pdf"
      )
  end

end
