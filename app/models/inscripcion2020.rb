class Inscripcion2020 < ApplicationRecord
  belongs_to :alumno
  belongs_to :padre, :class_name => "Usuario"
  belongs_to :madre, :class_name => "Usuario"
  belongs_to :titular1, :class_name => "Usuario"
  belongs_to :titular2, :class_name => "Usuario"
  belongs_to :grado
  belongs_to :proximo_grado
  belongs_to :formulario2020
  belongs_to :convenio2020
  belongs_to :afinidad2020
  belongs_to :matricula2020
  belongs_to :hermanos2020
  belongs_to :cuota2020

  def self.FindInscripcion(a)
    return Inscripcion2020.where("alumno_id=#{a} AND reinscripcion AND #{ConsultaFecha()}").first rescue nil
  end

  def PuedeInscribir()
    return (inhabilitado != nil) && !inhabilitado && (fecha_pase == nil)
  end

  def EstaInscripto()
    return fecha_inscripto != nil
  end

  def HayVale()
    return fecha_vale != nil
  end

  def EstaRegistrado()
    return fecha_registrado != nil
  end

  def self.ConsultaFecha()
    return "fecha_comienzo<='#{DateTime.now.strftime("%Y-%m-%d")}' AND (fecha_fin IS NULL OR fecha_fin>='#{DateTime.now.strftime("%Y-%m-%d")}')"
  end

  def self.Consulta(alumno, campo, tabla)
    return "fecha_comienzo<='#{DateTime.now.strftime("%Y-%m-%d")}' AND (fecha_fin IS NULL OR fecha_fin>='#{DateTime.now.strftime("%Y-%m-%d")}') AND " +
           "(general OR (id IN (SELECT #{campo} FROM #{tabla} WHERE alumno_id=#{alumno})))"
  end



  def self.OpcionesGrados(inscripcionAlumno)
    opciones = Array.new
    ProximoGrado.where("grado_id=#{inscripcionAlumno.grado_id} AND anio=2021").order(:nombre).each do |opcion|
      opciones.push( ["#{opcion.nombre} - $#{opcion.precio.to_i.to_s}",opcion.id] )
    end 
    return opciones
  end


  def self.OpcionesConvenio(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["",nil] )
    Convenio2020.where(ConsultaFecha()).order(:nombre).each do |opcion|
      opciones.push( [opcion.nombre,opcion.id] )
    end 
    return opciones
  end

  def self.OpcionesAfinidad(inscripcionAlumno)
    afinidad = Afinidad2020.where("id IN (SELECT afinidad2020_id FROM inscripcion2020s WHERE alumno_id=#{inscripcionAlumno.alumno_id} AND #{ConsultaFecha()})").first
    return afinidad
  end

  def self.OpcionesAdicional(inscripcionAlumno)
    inscripcion = Inscripcion2020.where("alumno_id=#{inscripcionAlumno.alumno_id} AND #{ConsultaFecha()}").first
    return inscripcion
  end

  def self.OpcionesHermanos(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["",nil] )
    Hermanos2020.where(ConsultaFecha()).order(:nombre).each do |opcion|
      opciones.push( [opcion.nombre,opcion.id] )
    end 
    return opciones
  end

  def self.OpcionesCuotas(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["",nil] )
    Cuota2020.where(Consulta(inscripcionAlumno.alumno_id,"cuota2020_id","cuota2020s")).order(:nombre).each do |opcion|
      opciones.push( [opcion.nombre,opcion.id] )
    end 
    return opciones
  end

  def self.OpcionesMatricula(inscripcionAlumno)
    opciones = Array.new
    opciones.push( ["",nil] )
    Matricula2020.where(Consulta(inscripcionAlumno.alumno_id,"matricula2020_id","matricula2020s")).order(:nombre).each do |opcion|
      opciones.push( [opcion.nombre,opcion.id] )
    end 
    return opciones
  end

end
