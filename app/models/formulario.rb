class Formulario < ApplicationRecord

  def self.OpcionesFormulario(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["Prueba 1",1] )
    return opciones
  end

  def self.OpcionesConvenio(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["Prueba 1",1] )
    return opciones
  end

  def self.OpcionesAdicional(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["Prueba 1",1] )
    return opciones
  end

  def self.OpcionesHermanos(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["Prueba 1",1] )
    return opciones
  end

  def self.OpcionesCuotas(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["Prueba 1",1] )
    return opciones
  end

  def self.OpcionesMatricula(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["Prueba 1",1] )
    return opciones
  end

end
