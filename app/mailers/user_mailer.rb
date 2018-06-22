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
		mail(to: 'soporte@varela.edu.uy', subject: 'Registro de nuevo usuario de eventos')
	end

end
