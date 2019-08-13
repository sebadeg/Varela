class ProximoGrado < ApplicationRecord

  def self.OpcionesGrados(inscripcionAlumno)
  	opciones = Array.new
  	opciones.push( ["Prueba 1",1] )
  	return opciones
  end

end
