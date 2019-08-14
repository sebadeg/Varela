class Inscripcion < ApplicationRecord
  belongs_to :convenio
  belongs_to :proximo_grado

  attr_accessor :nombre, :apellido, :lugar_nacimiento, :fecha_nacimiento, :domicilio, :celular, :mutualista, :emergencia, :apellido1, :cedula1, :apellido2, :cedula2

  def self.FindInscripcion(a)
    inscripcion = Inscripcion.where("alumno_id=#{a} AND reinscripcion AND anio IN (SELECT anio_inscripciones FROM configs WHERE NOT anio_inscripciones IS NULL)").first rescue nil

    alumno = Alumno.find(inscripcion.alumno_id) rescue nil
    if alumno != nil
      inscripcion.nombre = alumno.nombre
      inscripcion.apellido = alumno.apellido
      inscripcion.lugar_nacimiento = alumno.lugar_nacimiento
      inscripcion.fecha_nacimiento = alumno.fecha_nacimiento
      inscripcion.domicilio = alumno.domicilio
      inscripcion.celular = alumno.celular
      inscripcion.mutualista = alumno.mutualista
      inscripcion.emergencia = alumno.emergencia
    end

    padre = Persona.find(inscripcion.cedula_padre) rescue nil
    if padre != nil
      inscripcion.nombre_padre = padre.nombre
      inscripcion.apellido_padre = padre.apellido
      inscripcion.cedula_padre = padre.id
      inscripcion.domicilio_padre = padre.domicilio
      inscripcion.email_padre = padre.email
      inscripcion.celular_padre = padre.celular
      inscripcion.profesion_padre = padre.profesion
      inscripcion.trabajo_padre = padre.trabajo
      inscripcion.telefono_trabajo_padre = padre.telefono_trabajo
    end

    madre = Persona.find(inscripcion.cedula_madre) rescue nil
    if madre != nil
      inscripcion.nombre_madre = madre.nombre
      inscripcion.apellido_madre = madre.apellido
      inscripcion.cedula_madre = madre.id
      inscripcion.domicilio_madre = madre.domicilio
      inscripcion.email_madre = madre.email
      inscripcion.celular_madre = madre.celular
      inscripcion.profesion_madre = madre.profesion
      inscripcion.trabajo_madre = madre.trabajo
      inscripcion.telefono_trabajo_madre = madre.telefono_trabajo
    end

    titular1 = Persona.find(inscripcion.documento1) rescue nil
    if titular1 != nil
      inscripcion.nombre1 = titular1.nombre
      inscripcion.apellido1 = titular1.apellido
      inscripcion.cedula1 = titular1.id
      inscripcion.domicilio1 = titular1.domicilio
      inscripcion.email1 = titular1.email
      inscripcion.celular1 = titular1.celular
    end

    titular2 = Persona.find(inscripcion.documento2) rescue nil
    if titular2 != nil
      inscripcion.nombre2 = titular2.nombre
      inscripcion.apellido2 = titular2.apellido
      inscripcion.cedula2 = titular2.id
      inscripcion.domicilio2 = titular2.domicilio
      inscripcion.email2 = titular2.email
      inscripcion.celular2 = titular2.celular
    end
    
    return inscripcion

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
