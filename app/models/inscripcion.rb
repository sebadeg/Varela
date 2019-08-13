class Inscripcion < ApplicationRecord
  belongs_to :convenio
  belongs_to :proximo_grado

  def self.FindInscripcion(alumno)
    return Inscripciones.where("alumno_id=#{alumno} AND anio IN (SELECT anio_inscripciones FROM configs WHERE NOT anio_inscripciones IS NULL)").first rescue nil
  end

  def PuedeInscribir(alumno)
    return false;
  end

  def EstaInscripto(alumno)
    return false;
  end

  def EstaRegistrado(alumno)
    return false;
  end

end
