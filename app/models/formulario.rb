class Formulario < ApplicationRecord

  def self.OpcionesFormulario(inscripcionAlumno)
    opciones = Array.new
    Formulario.where("cedula=#{inscripcionAlumno.cedula} AND " + 
      "anio IN (SELECT anio_inscripciones FROM configs WHERE NOT anio_inscripciones IS NULL) AND " +
      "id IN (SELECT formulario_id FROM formulario_alumnos WHERE cedula=#{inscripcionAlumno.cedula} AND NOT formulario_id IS NULL)"
      ).each do |formulario|
      opciones.push( [formulario.nombre,formulario.id] )
    end
    return opciones
  end

  def self.OpcionesPorNombre(inscripcionAlumno,nombre)
    opciones = Array.new
    tipo = InscripcionOpcionTipo.where("nombre='#{nombre}'").first rescue nil
    if tipo == nil 
      return opciones
    end
    InscripcionOpcion.where("inscripcion_opcion_tipo_id=#{tipo.id} AND (general OR id IN (SELECT inscripcion_opcion_id FROM inscripcion_opcion_alumnos WHERE cedula=#{inscripcionAlumno.cedula} AND NOT inscripcion_opcion_id IS NULL))").order(:orden).each do |opcion|
      opciones.push( [opcion.nombre,opcion.id] )
    end 
    return opciones
  end

  def self.OpcionesConvenio(inscripcionAlumno)
    return OpcionesPorNombre(inscripcionAlumno,'Convenio')
  end

  def self.OpcionesAdicional(inscripcionAlumno)
    return OpcionesPorNombre(inscripcionAlumno,'Adicional')
  end

  def self.OpcionesHermanos(inscripcionAlumno)
    return OpcionesPorNombre(inscripcionAlumno,'Hermanos')
  end

  def self.OpcionesCuotas(inscripcionAlumno)
    return OpcionesPorNombre(inscripcionAlumno,'Cuotas')
  end

  def self.OpcionesMatricula(inscripcionAlumno)
    return OpcionesPorNombre(inscripcionAlumno,'Matrícula')
  end

end
