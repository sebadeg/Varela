class Inscripcion < ApplicationRecord
  belongs_to :convenio
  belongs_to :proximo_grado

  attr_accessor :nombre, :apellido, :lugar_nacimiento, :fecha_nacimiento, :domicilio, :celular, :mutualista, :emergencia, :apellido1, :apellido2

  def self.FindInscripcion(alumno)
    return Inscripcion.where("alumno_id=#{alumno} AND reinscripcion AND anio IN (SELECT anio_inscripciones FROM configs WHERE NOT anio_inscripciones IS NULL)").first rescue nil
  end

  def PuedeInscribir()
    return !inhabilitado && (fecha_pase == nil)
  end

  def EstaInscripto()
    return inscripto
  end

  def EstaRegistrado()
    return registrado
  end

end
