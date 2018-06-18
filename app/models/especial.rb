class Especial < ApplicationRecord
  has_many :especial_alumno, :dependent => :delete_all
  accepts_nested_attributes_for :especial_alumno, allow_destroy: true

  def importar(attrs)

    self.fecha_comienzo = attrs[:fecha_comienzo]
    self.fecha_fin = attrs[:fecha_fin]
    self.descripcion = attrs[:descripcion]
    self.importe = attrs[:importe]

  	if attrs[:nombre] != nil
	  	file = attrs[:nombre]
	    self.nombre = file.original_filename
	    self.data = file.read
	  end

    if !self.save 
      return false
    end

    if attrs[:nombre] == nil
    	return true
    end

    archs = Array.new

    file = Tempfile.new(nombre)

    nombre_tmp = file.path

    p nombre_tmp

    IO.binwrite(nombre_tmp, data)

    s = File.readlines(nombre_tmp)
    s.each do |line| 
      alumno = Alumno.find(line.to_i) rescue nil
      if alumno != nil
        archs.push(alumno.id)
      end
    end

    file.unlink

    indice = 0
    archs.each do |arch|
      especialAlumno = EspecialAlumno.find_or_create_by!( especial_id: id, indice: indice )
      especialAlumno.alumno_id = arch
      especialAlumno.save!
      indice = indice+1
    end    

    EspecialAlumno.destroy_all( "especial_id=#{id} AND indice>=#{archs.length}")
  end
end
