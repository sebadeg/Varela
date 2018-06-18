class Archivo < ApplicationRecord
	
  require 'digest/md5'

  class << self
    def importar(archivos)
      archivo = archivos.each do |file|
		datos = IO.binread(file.path) #ActiveRecord::Base.connection.escape_bytea(IO.binread( file.original_filename ))
        a = Archivo.create(  
              nombre: file.original_filename, 
              data: datos,
              md5: Digest::MD5.hexdigest(datos),
            )
      end
      return "OK"
    end

	def exportar()
      archivo = Archivo.all.each do |file|
        ext = file.nombre.slice(file.nombre.rindex("."), file.nombre.length).downcase;

        nombre = Rails.root.join("public", file.nombre)
        IO.binwrite(nombre, file.data)

      end
      return "OK"
    end

  end

end
