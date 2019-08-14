class ProximoGrado < ApplicationRecord

  def self.OpcionesGrados(inscripcionAlumno)
  	opciones = Array.new
    tipo = ProximoGrado.where("anio IN (SELECT anio_inscripciones FROM configs WHERE NOT anio_inscripciones IS NULL)").order(:nombre).each do |opcion|
      opciones.push( [opcion.nombre,opcion.id] )
    end 
  	return opciones
  end

end
