class Inscripcion < ApplicationRecord
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




    def vale(file_path)

      proximo_grado = ProximoGrado.find(proximo_grado_id) rescue nil

      importe_total = proximo_grado.precio

      descuentos = Array.new

      

      if formulario_id != nil
        formulario = Formulario.find(formulario_id) rescue nil
        FormularioInscripcionOpcion.where("formulario_id=#{formulario_id} AND inscripcion_opcion_id IN (SELECT id FROM InscripcionOpcion WHERE nombre IN ('Convenio','Adicional','Hermanos'))").each do |formulario_inscripcion_opcion|
          descuentos.push(formulario_inscripcion_opcion.inscripcion_opcion_id)
        end
        cuotas = 0
        FormularioInscripcionOpcion.where("formulario_id=#{formulario_id} AND inscripcion_opcion_id IN (SELECT id FROM InscripcionOpcion WHERE nombre='Cuotas')").each do |formulario_inscripcion_opcion|
          inscripcion_opcion_cuotas = InscripcionOpcion.find(formulario_inscripcion_opcion.inscripcion_opcion_id) rescue nil
          if inscripcion_opcion_cuotas != nil
            cuotas = cuotas + inscripcion_opcion_cuotas.valor_ent
          end
        end        
      else
        descuentos = [convenio_id,adicional_id,hermanos_id]
        inscripcion_opcion_cuotas = InscripcionOpcion.find(cuotas_id) rescue nil 
        cuotas = 12
        if inscripcion_opcion_cuotas != nil
          cuotas = inscripcion_opcion_cuotas.valor_ent
        end
      end

      descuentos.each do |inscripcion_opcion_id|
        inscripcion_opcion = InscripcionOpcion.find(inscripcion_opcion_id) rescue nil
        if inscripcion_opcion != nil 
          importe_total = importe_total * ( 100.0 - inscripcion_opcion.valor ) / 100.0
        end
      end

      importe_cuota = (importe_total/cuotas+0.5).to_i
      importe_total = (importe_cuota*cuotas).to_i
      importe_letras = numero_a_letras(importe_total,true)

      # if ( inscripcionAlumno.mes == 12 )
      #   desde = DateTime.new(2018,12,10)
      #   anio = 2018
      # else
      #   desde = DateTime.new(2019,inscripcionAlumno.mes,10)
      #   anio = 2019
      # end
      # mes = I18n.l(desde, format: '%B')
      # hoy = DateTime.now
      # hoyS = "#{hoy.day} de #{hoy.month} de #{hoy.year}"

      cedula_alumno = cedula_tos(cedula)

      nombre_alumno = ""
      alumno = Alumno.find_by(cedula: cedula)
      if alumno != nil 
        nombre_alumno = alumno.nombre + " " + alumno.apellido
      end

      nombre_grado = ""
      grado = ProximoGrado.find(proximo_grado_id)
      if grado != nil
        nombre_grado = grado.nombre
      end

      reinscripcion =  "<b>REINSCRIPCION</b>"

      informacion = 
        "El alumno #{nombre_alumno} cuya cédula es #{cedula_alumno} ha comenzado el proceso de reinscripción para el año lectivo #{anio} en " + 
        "#{nombre_grado} del Colegio Nacional José Pedro Varela."

      cabezal = 
        "$U <b>#{importe_total}</b>" + 
        "<br><br>" +
        "Lugar y fecha de emisión: <b>Montevideo, #{I18n.l(DateTime.now, format: '%-d de %B de %Y')}</b>";

      texto =
        "<b>VALE AMORTIZABLE</b> por la cantidad de pesos uruguayos <b>#{importe_letras}</b> que debo (debemos) y pagaré (pagaremos) en forma " +
        "indivisible y solidaria a la Sociedad Uruguaya de Enseñanza, Colegio Nacional José Pedro Varela - o a su orden, en la misma moneda, en " +
        "<b>#{cuotas}</b> cuotas mensuales, iguales y consecutivas de $U <b>#{importe_cuota}</b> cada una, venciendo la primera el día 10 de "+ 
        "<b>#{mes}</b> del <b>#{anio}</b>, en el domicilio del acreedor sito en la calle Colonia 1637 de la ciudad de Montevideo, o donde indique " + 
        "el acreedor." +
        "<br><br>" + 
        "La falta de pago de dos o más cuotas a su vencimiento producirá la mora de pleno derecho sin necesidad de interpelación de clase alguna, " +
        "devengándose por esa sola circunstancias, intereses moratorios del 40% (cuarenta por ciento) tasa efectiva anual (aprobada por BCU) y hará " +
        "exigible la totalidad del monto adeudado más los intereses moratorios generados a partir del incumplimiento y hasta su efectiva y total " + 
        "cancelación." +
        "<br><br>" + 
        "En caso de incumplimiento total o parcial del presente título, el acreedor a su elección, podrá demandar la ejecución de este título ante " +
        "los Jueces del lugar de residencia del deudor o ante los del lugar del cumplimiento de la obligación." +
        "<br><br>" + 
        "Para todos los efectos judiciales y/o extrajudiciales a que pudiera dar lugar éste documento, el deudor constituye como domicilio especial el " +
        "abajo denunciado." +
        "<br><br><br>" + 
        "NOMBRE COMPLETO: #{inscripcionAlumno.nombre1}<br><br>" +
        "DOCUMENTO DE IDENTIDAD: #{cedula_tos(inscripcionAlumno.documento1)}<br><br>" +
        "DOMICILIO: #{inscripcionAlumno.domicilio1}<br><br>" +
        "MAIL: #{inscripcionAlumno.email1}<br><br>" +
        "TEL/CEL: #{inscripcionAlumno.celular1}<br><br>" +
        "FIRMA:<br><br>" +
        "Aclaración:<br><br>" +
        "<br><br>" +
        "NOMBRE COMPLETO: #{inscripcionAlumno.nombre2}<br><br>" +
        "DOCUMENTO DE IDENTIDAD: #{cedula_tos(inscripcionAlumno.documento2)}<br><br>" +
        "DOMICILIO: #{inscripcionAlumno.domicilio2}<br><br>" +
        "MAIL: #{inscripcionAlumno.email2}<br><br>" +
        "TEL/CEL: #{inscripcionAlumno.celular2}<br><br>" +
        "FIRMA:<br><br>" +
        "Aclaración:<br><br>";


      text_file = Tempfile.new("text.pdf")
      text_file_path = text_file.path

      Prawn::Document.generate(text_file_path) do
        font "Helvetica", :size => 12

        stroke_color "0000FF"
        stroke_rectangle [0, 720], 540, 720   
        stroke_color "FF0000"
        stroke_rectangle [2, 718], 536, 716

        image Rails.root.join("data", "logo.png"), at: [203,555], scale: 0.5

        bounding_box([20, 355], :width => 500, :height => 60) do
          text reinscripcion, align: :center, inline_format: true
          #transparent(0) { stroke_bounds }
        end

        bounding_box([60, 325], :width => 420, :height => 60) do
          text informacion, align: :center, inline_format: true
          #transparent(0) { stroke_bounds }
        end

        start_new_page

        font "Helvetica", :size => 10

        stroke_color "0000FF"
        stroke_rectangle [0, 720], 540, 720   
        stroke_color "FF0000"
        stroke_rectangle [2, 718], 536, 716

        bounding_box([20, 700], :width => 500, :height => 60) do
          text cabezal, align: :right, inline_format: true
          #transparent(0) { stroke_bounds }
        end
        bounding_box([20, 640], :width => 500, :height => 600) do
          text texto, align: :justify, inline_format: true
          #transparent(0) { stroke_bounds }
        end

      end

      pdf = CombinePDF.new
      pdf << CombinePDF.load(text_file_path)
      pdf.save file_path

      text_file.unlink

    end


end
