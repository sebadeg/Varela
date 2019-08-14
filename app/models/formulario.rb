class Formulario < ApplicationRecord

  def self.OpcionesFormulario(inscripcionAlumno)
    opciones = Array.new
    Formulario.where("cedula=#{inscripcionAlumno.cedula} AND anio IN (SELECT anio_inscripciones FROM configs WHERE NOT anio_inscripciones IS NULL)").each do |formulario|
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
    InscripcionOpcion.where("inscripcion_opcion_tipo_id=#{tipo.id} AND general").each do |opcion|
      opciones.push( [opcion.nombre,opcion.id] )
    end 
    return opciones
  end


  def self.OpcionesConvenio(inscripcionAlumno)
    return OpcionesPorNombre('Convenio')
  end

  def self.OpcionesAdicional(inscripcionAlumno)
    return OpcionesPorNombre('Adicional')
  end

  def self.OpcionesHermanos(inscripcionAlumno)
    return OpcionesPorNombre('Hermanos')
  end

  def self.OpcionesCuotas(inscripcionAlumno)
    return OpcionesPorNombre('Cuotas')
  end

  def self.OpcionesMatricula(inscripcionAlumno)
    return OpcionesPorNombre('Matrícula')
  end

end
