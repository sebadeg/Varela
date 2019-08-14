class Formulario < ApplicationRecord

  def self.OpcionesFormulario(inscripcionAlumno)
    opciones = Array.new
    Formulario.where("cedula=#{inscripcionAlumno.cedula} AND anio IN (SELECT anio_inscripciones FROM configs WHERE NOT anio_inscripciones IS NULL)").each do |formulario|
      opciones.push( [formulario.nombre,formulario.id] )
    end
    return opciones
  end

  def self.OpcionesConvenio(inscripcionAlumno)
    opciones = Array.new
    tipo = InscripcionOpcionTipo.where("nombre='Convenio'").first rescue nil
    if tipo == nil 
      return opciones
    end
    InscripcionOpcion.where("inscripcion_opcion_tipo_id=#{tipo.id} AND general").each do |opcion|
      opciones.push( [opcion.nombre,opcion.id] )
    end 
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
