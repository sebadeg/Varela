class UserMailer < ApplicationMailer

	def aceptar_usuario(usuario)
		@usuario = usuario
		mail(to: usuario.email, bcc:'soporte@varela.edu.uy', subject: 'Envío de contraseña de acceso')
		#mail(to: 'soporte@varela.edu.uy', subject: 'Envío de contraseña de acceso')
	end

	def nuevo_usuario(usuario)
		@usuario = usuario
		mail(to: 'soporte@varela.edu.uy', subject: 'Registro de nuevo usuario')
	end

	def eventos_usuario(usuario)
		@usuario = usuario
		mail(to: 'eventos@varela.edu.uy', bcc:'soporte@varela.edu.uy', subject: 'Registro de nuevo usuario de eventos')
	end

	def nueva_reinscripcion(inscripcionAlumno)

      mail = "soporte@varela.edu.uy"
      contrasena = Contrasena.find_by(mail: mail) rescue nil
      passwd = contrasena != nil ? contrasena.password : ""

	  delivery_options = {
        address: "smtp.varela.edu.uy",
	    port: 587,
	    domain: "varela.edu.uy", 
	    user_name: mail,
	    password: passwd,
	    authentication: "plain",
	    enable_starttls_auto: true,
	    openssl_verify_mode: 'none'
	  }

	  @inscripcionAlumno = inscripcionAlumno

      mail_to = Config.find(1).mail_inscripcion

      mail(from: mail, to: mail_to, subject: 'Nueva reinscripción', delivery_method_options: delivery_options)
	end


	# def reinscripcion(inscripcionAlumno,file_name,file)

	# 	@inscripcionAlumno = inscripcionAlumno

	# 	attachments[file_name] = {mime_type: "application/pdf" , content: File.read(file.path) }

	# 	mail(to: inscripcionAlumno.email1, bcc:'soporte@varela.edu.uy', subject: 'Comprobante de reinscripción')
	# end
end
