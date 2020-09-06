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
    return Inscripcion2020.where("alumno_id=#{a} AND reinscripcion AND anio=2021").first rescue nil
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
end
