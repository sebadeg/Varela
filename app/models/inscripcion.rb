class Inscripcion < ApplicationRecord
  belongs_to :proximo_grado

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
   
    return inscripcion

  end

  def Formulario() 
    return ""
  end

  def FindInscripcionOpcion(inscripcionOpcion) 
    inscripcionOpcion = InscripcionOpcion.where("id = #{inscripcionOpcion}").first rescue nil
    if inscripcionOpcion == nil
      return ""
    else
      return inscripcionOpcion.nombre
    end
  end

  def PuedeInscribir()
    return (inhabilitado != nil) && !inhabilitado && (fecha_pase == nil)
  end

  def EstaInscripto()
    return (inscripto != nil) && inscripto
  end

  def HayVale()
    return (hay_vale != nil) && hay_vale
  end

  def EstaRegistrado()
    return (registrado != nil) && registrado
  end

  def CalcularPrecio()

    proximo_grado = ProximoGrado.find(proximo_grado_id) rescue nil
    importe_total = proximo_grado.precio

    descuentos = Array.new

    # formulario = Formulario.find(formulario_id) rescue nil
    # FormularioInscripcionOpcion.where("formulario_id=#{formulario_id} AND inscripcion_opcion_id IN (SELECT id FROM inscripcion_opciones WHERE " +
    #   "inscripcion_opcion_tipo_id IN (SELECT id FROM inscripcion_opcion_tipos WHERE nombre='Convenio' AND NOT id IS NULL))"
    #   ).each do |formulario_inscripcion_opcion|
    #   descuentos.push(formulario_inscripcion_opcion.inscripcion_opcion_id)
    # end
    descuentos.push(convenio_id)

    # FormularioInscripcionOpcion.where("formulario_id=#{formulario_id} AND inscripcion_opcion_id IN (SELECT id FROM inscripcion_opciones WHERE " +
    #   "inscripcion_opcion_tipo_id IN (SELECT id FROM inscripcion_opcion_tipos WHERE nombre='Adicional' AND NOT id IS NULL))"
    #   ).each do |formulario_inscripcion_opcion|
    #   descuentos.push(formulario_inscripcion_opcion.inscripcion_opcion_id)
    # end
    descuentos.push(adicional_id)

    # FormularioInscripcionOpcion.where("formulario_id=#{formulario_id} AND inscripcion_opcion_id IN (SELECT id FROM inscripcion_opciones WHERE " +
    #   "inscripcion_opcion_tipo_id IN (SELECT id FROM inscripcion_opcion_tipos WHERE nombre='Hermanos' AND NOT id IS NULL))"
    #   ).each do |formulario_inscripcion_opcion|
    #   descuentos.push(formulario_inscripcion_opcion.inscripcion_opcion_id)
    # end
    descuentos.push(hermanos_id)

    p "------------------------------"
    p "------------------------------"
    p "------------------------------"
    p importe_total
    p descuentos


    descuentos.each do |inscripcion_opcion_id|
      inscripcion_opcion = InscripcionOpcion.find(inscripcion_opcion_id) rescue nil
      if inscripcion_opcion != nil 
        p inscripcion_opcion.valor
        importe_total = importe_total * ( 100.0 - inscripcion_opcion.valor ) / 100.0
      end
    end

    p importe_total
    p "------------------------------"
    p "------------------------------"
    p "------------------------------"

    cuotas = Array.new
    numero_cuotas = 0
    fecha_cuota = nil
    # if formulario_id != nil
    #   InscripcionOpcion.where( "id IN (SELECT inscripcion_opcion_id FROM formulario_inscripcion_opciones " +
    #     "WHERE formulario_id=#{formulario_id} AND NOT inscripcion_opcion_id IS NULL) AND " +
    #     "inscripcion_opcion_tipo_id IN (SELECT id FROM inscripcion_opcion_tipos WHERE nombre='Cuotas' AND NOT id IS NULL)"
    #     ).each do |inscripcion_opcion_cuotas|
    #     if ( inscripcion_opcion_cuotas.valor == nil )
    #       numero_cuotas = inscripcion_opcion_cuotas.valor_ent
    #       if fecha_cuota == nil
    #         fecha_cuota = inscripcion_opcion_cuotas.fecha
    #       end
    #     else            
    #       cuotas.push([inscripcion_opcion_cuotas.valor_ent,inscripcion_opcion_cuotas.valor,inscripcion_opcion_cuotas.fecha])
    #     end
    #   end        
    # else
      inscripcion_opcion_cuotas = InscripcionOpcion.find(cuotas_id) rescue nil 
      if inscripcion_opcion_cuotas != nil
        if ( inscripcion_opcion_cuotas.valor == nil )
          numero_cuotas = inscripcion_opcion_cuotas.valor_ent
          fecha_cuota = inscripcion_opcion_cuotas.fecha
        else            
          cuotas.push([inscripcion_opcion_cuotas.valor_ent,inscripcion_opcion_cuotas.valor,inscripcion_opcion_cuotas.fecha])
        end
      end
    #end    

    if cuotas.count == 0 && numero_cuotas != 0 
      cuotas.push([numero_cuotas,(importe_total/numero_cuotas+0.5).to_i,fecha_cuota])
    end

    return cuotas
  end

  def CalcularPrecioToStr()

    str = ""

    cuotas = CalcularPrecio()

    total = 0
    cuotas.each do |cuota|
      if str != ""
        str = str + " + "        
      end
      if cuota[2] != nil
        str = str + "(#{cuota[2].strftime("%d/%m/%Y")})"
      end
      str = str + " #{cuota[0]} x #{cuota[1]}"

      total = total + cuota[0]*cuota[1]
    end
    str = str + " = #{total}"

    return str
  end


  def self.numero_a_letras(n, uno)
    s = ""
    if (n/1000>0)
      s = numero_a_letras((n/1000).to_i,false) + " mil ";
    end
    n = (n%1000).to_i;
    case (n/100).to_i
    when 1
      if n%100 != 0
        s = s + "ciento"
      else
        s = s + "cien"
      end
    when 2
      s = s + "doscientos"
    when 3
      s = s + "trescientos"
    when 4
      s = s + "cuatrocientos"
    when 5
      s = s + "quinientos"
    when 6
      s = s + "siescientos"
    when 7
      s = s + "setecientos"
    when 8
      s = s + "ochocientos"
    when 9
      s = s + "novecientos"
    end
    n = (n%100).to_i
    if n > 0
      s = s + " "
    end
    case (n/10).to_i
    when 3
      s = s + "treinta"
    when 4
      s = s + "cuarenta"
    when 5
      s = s + "cincuenta"
    when 6
      s = s + "sesenta"
    when 7
      s = s + "setenta"
    when 8
      s = s + "ochenta"
    when 9
      s = s + "noventa"
    end
    if ( n >= 30 )
      if (n%10).to_i != 0
        s = s + " y "
      end
      n = (n%10).to_i
    end
    case n          
    when 1
      if ( uno )
        s = s + "uno"
      else
        s = s + "un"
      end
    when 2
      s = s + "dos"
    when 3
      s = s + "tres"
    when 4
      s = s + "cuatro"
    when 5
      s = s + "cinco"
    when 6
      s = s + "seis"
    when 7
      s = s + "siete"
    when 8
      s = s + "ocho"
    when 9
      s = s + "nueve"
    when 10
      s = s + "diez"
    when 11
      s = s + "once"
    when 12
      s = s + "doce"
    when 13
      s = s + "trece"
    when 14
      s = s + "catorce"
    when 15
      s = s + "quince"
    when 16
      s = s + "dieciseis"
    when 17
      s = s + "diecisiete"
    when 18
      s = s + "dieciocho"
    when 19
      s = s + "diecinueve"
    when 20
      s = s + "veinte"
    when 21
      if uno
        s = s + "veintiuno"
      else
        s = s + "veintiun"
      end
    when 22
      s = s + "veintidos"
    when 23
      s = s + "veintitres"
    when 24
      s = s + "veinticuatro"
    when 25
      s = s + "veinticinco"
    when 26
      s = s + "veintiseis"
    when 27
      s = s + "veintisiete"
    when 28
      s = s + "veintiocho"
    when 29
      s = s + "veintinueve"
    end
    return s
  end

  def self.cedula_tos(cedula)
    if ( cedula == nil )
      return ""
    end
    return (cedula/10).to_s + "-" + (cedula%10).to_s
  end

  def fecha_tos(fecha)
    if ( fecha == nil )
      return ""
    end
    return I18n.l(fecha, format: '%-d de %B de %Y')
  end

  def self.numero_cuota_letras(cuota)
    s = "".force_encoding(Encoding::UTF_8)
    case cuota
    when 1
      s = "primera"
    when 2
      s = "segunda"
    when 3
      s = "tercera"
    when 4
      s = "cuarta"
    when 5
      s = "quinta"
    when 6
      s = "sexta"
    when 7
      s = "septima"
    when 8
      s = "octava"
    when 9
      s = "novena"
    when 10
      s = "d�cima".force_encoding(Encoding::UTF_8)
    when 11
      s = "und�cima".force_encoding(Encoding::UTF_8)
    when 12
      s = "duod�cima".force_encoding(Encoding::UTF_8)
    when 13
      s = "decimotercera"
    when 14
      s = "decimocuarta"
    when 15
      s = "decimoquinta"
    when 16
      s = "decimosexta"
    when 17
      s = "decimoseptima"
    when 18
      s = "decimoctava"
    when 19
      s = "decimonovena"
    when 20
      s = "vig�sima".force_encoding(Encoding::UTF_8)
    when 21
      s = "vigesimoprimera"
    when 22
      s = "vigesimosegunda"
    when 23
      s = "vigesimotercera"
    when 24
      s = "vigesimocuarta"
    end
    return s
  end

  def cuotas_a_letras(cuotas)
    if cuotas.count == 1
      if cuotas[0][0] == 1        
        return "<b>1</b> cuota de $U <b>#{cuotas[0][1]}</b>, venciendo el d�a #{I18n.l(cuotas[0][2], format: '<b>%-d</b> de <b>%B</b> de <b>%Y</b>')}"
      else
        return "<b>#{cuotas[0][0]}</b> cuotas mensuales, iguales y consecutivas de $U <b>#{cuotas[0][1]}</b> cada una, venciendo la primera el d�a #{I18n.l(cuotas[0][2], format: '<b>%-d</b> de <b>%B</b> de <b>%Y</b>')}"
      end
    else
      mensaje = ""
      cuota = 0
      cuotas.each do |c|
        if mensaje != ""
          mensaje = mensaje + ", "
        end
        if c[0] == 1
          mensaje = mensaje + "la #{numero_cuota_letras(cuota+1)} de $U <b>#{c[1]}</b> venciendo el d�a #{I18n.l(c[2], format: '<b>%-d</b> de <b>%B</b> de <b>%Y</b>')}"
        else
          mensaje = mensaje + "de la #{numero_cuota_letras(cuota+1)} a la #{numero_cuota_letras(cuota+c[0])} de $U <b>#{c[1]}</b> venciendo el d�a #{I18n.l(c[2], format: '<b>%-d</b> de <b>%B</b> de <b>%Y</b>')} y cada mes subsiguiente"
        end
        cuota = cuota + c[0]
      end
      return "<b>#{cuota}</b> cuotas, a saber: " + mensaje
    end
  end



  def vale(file_path)

    cuotas = CalcularPrecio()

    total = 0
    cuotas.each do |cuota|
      total = total + cuota[0]*cuota[1]
    end


    total_letras = Inscripcion.numero_a_letras(total,true)

    cedula_alumno = Inscripcion.cedula_tos(cedula)

    nombre_alumno = ""
    alumno = Alumno.find_by(cedula: cedula) rescue nil
    if alumno != nil 
      nombre_alumno = alumno.nombre + " " + alumno.apellido
    end

    nombre_grado = ""
    proximo_grado = ProximoGrado.find(proximo_grado_id) rescue nil
    if proximo_grado != nil
      nombre_grado = proximo_grado.nombre
    end

    convenio_nombre = ""
    matricula_nombre = ""
    hermanos_nombre = ""
    if formulario_id != nil
      formulario = Formulario.find(formulario_id) rescue nil
      if formulario != nil 
        convenio_nombre = formulario.nombre
      end
    else
      inscripcion_opcion = InscripcionOpcion.find(convenio_id) rescue nil
      if inscripcion_opcion != nil 
        convenio_nombre = inscripcion_opcion.nombre
      end
      inscripcion_opcion = InscripcionOpcion.find(adicional_id) rescue nil
      if inscripcion_opcion != nil 
        convenio_nombre = convenio_nombre + " + " + inscripcion_opcion.nombre
      end

      inscripcion_opcion = InscripcionOpcion.find(matricula_id) rescue nil
      if inscripcion_opcion != nil 
        matricula_nombre = inscripcion_opcion.nombre
      end

      inscripcion_opcion = InscripcionOpcion.find(hermanos_id) rescue nil
      if inscripcion_opcion != nil 
        hermanos_nombre = inscripcion_opcion.nombre
      end
    end

    inscripcion = Inscripcion.FindInscripcion(alumno_id)

    idx=0
    nombreT = Array.new
    documentoT = Array.new
    domicilioT = Array.new
    emailT = Array.new
    celularT = Array.new

    if (inscripcion.titular_padre)
      nombreT[idx] = inscripcion.nombre_padre + " " + inscripcion.apellido_padre
      documentoT[idx] = inscripcion.cedula_padre
      domicilioT[idx] = inscripcion.domicilio_padre
      emailT[idx] = inscripcion.email_padre
      celularT[idx] = inscripcion.celular_padre
      idx = idx+1
    end

    if (inscripcion.titular_madre)
      nombreT[idx] = inscripcion.nombre_madre + " " + inscripcion.apellido_madre
      documentoT[idx] = inscripcion.cedula_madre
      domicilioT[idx] = inscripcion.domicilio_madre
      emailT[idx] = inscripcion.email_madre
      celularT[idx] = inscripcion.celular_madre
      idx = idx+1
    end

    if inscripcion.documento1 != nil
      nombreT[idx] = "#{inscripcion.nombre1} #{inscripcion.apellido1}"
      documentoT[idx] = inscripcion.documento1
      domicilioT[idx] = inscripcion.domicilio1
      emailT[idx] = inscripcion.email1
      celularT[idx] = inscripcion.celular1
      idx = idx+1
    end

    if inscripcion.documento2 != nil
      nombreT[idx] = "#{inscripcion.nombre2} #{inscripcion.apellido2}"
      documentoT[idx] = inscripcion.documento2
      domicilioT[idx] = inscripcion.domicilio2
      emailT[idx] = inscripcion.email2
      celularT[idx] = inscripcion.celular2
      idx = idx+1
    end


    if reinscripcion
      titulo = "<b>REINSCRIPCION</b>"
    else
      titulo = "<b>INSCRIPCION</b>"
    end

    texto_inscripcion =
      "#{titulo}<br>"+      
      "Fecha: #{fecha_tos(inscripcion.created_at)}<br>" +
      "Recibida por: #{inscripcion.recibida}<br>" +
      "<br>" +
      "<b>NIVEL</b><br>" +
      "Grado: #{nombre_grado}<br>" +
      "Descuento: #{convenio_nombre}<br>" +
      "Matr�cula: #{matricula_nombre}<br>" +
      "Hermanos: #{hermanos_nombre}<br>" +
      "<br>"+
      "<b>ALUMNO</b><br>" +
      "Nombre: #{inscripcion.nombre} #{inscripcion.apellido}<br>" +
      "Documento de identidad: #{Inscripcion.cedula_tos(inscripcion.cedula)}<br>" +
      "Lugar de nacimiento: #{inscripcion.lugar_nacimiento}<br>" +
      "Fecha de nacimiento: #{fecha_tos(inscripcion.fecha_nacimiento)}<br>" +
      "Domicilio: #{inscripcion.domicilio}<br>" + 
      "Tel�fono/Celular: #{inscripcion.celular}<br>" + 
      "Mutualista: #{inscripcion.mutualista}<br>" + 
      "Emergencia: #{inscripcion.emergencia}<br>" + 
      "Procede de: #{inscripcion.procede}<br>"

      texto_padre =
      "<b>PADRE</b><br>" +
      "Nombre: #{inscripcion.nombre_padre} #{inscripcion.apellido_padre}<br>" +
      "Documento de identidad: #{Inscripcion.cedula_tos(inscripcion.cedula_padre)}<br>" +
      "Lugar de nacimiento: #{inscripcion.lugar_nacimiento_padre}<br>" +
      "Fecha de nacimiento: #{fecha_tos(inscripcion.fecha_nacimiento_padre)}<br>" +
      "Mail: #{inscripcion.email_padre}<br>" + 
      "Domicilio: #{inscripcion.domicilio_padre}<br>" + 
      "Tel�fono/Celular: #{inscripcion.celular_padre}<br>" + 
      "Profesi�n: #{inscripcion.profesion_padre}<br>" + 
      "Lugar de trabajo: #{inscripcion.trabajo_padre}<br>" + 
      "Tel�fono de trabajo: #{inscripcion.telefono_trabajo_padre}<br>" 

      texto_madre =
      "<b>MADRE</b><br>" +
      "Nombre: #{inscripcion.nombre_madre} #{inscripcion.apellido_madre}<br>" +
      "Documento de identidad: #{Inscripcion.cedula_tos(inscripcion.cedula_madre)}<br>" +
      "Lugar de nacimiento: #{inscripcion.lugar_nacimiento_madre}<br>" +
      "Fecha de nacimiento: #{fecha_tos(inscripcion.fecha_nacimiento_madre)}<br>" +
      "Mail: #{inscripcion.email_madre}<br>" + 
      "Domicilio: #{inscripcion.domicilio_madre}<br>" + 
      "Tel�fono/Celular: #{inscripcion.celular_madre}<br>" + 
      "Profesi�n: #{inscripcion.profesion_madre}<br>" + 
      "Lugar de trabajo: #{inscripcion.trabajo_madre}<br>" + 
      "Tel�fono de trabajo: #{inscripcion.telefono_trabajo_madre}<br><br>"

    texto_nota = "<b>NOTA: Para la inscripci�n deber� presentar: fotocopia de la C.I. del/los Titular/es de la cuenta y si corresponde Libre de Deuda o recibo del �ltimo pago realizado en la Instituci�n de donde proviene.<br><br>" +
           "LA AUTORIZACI�N DEFINITIVA SER� DADA UNA VEZ REALIZADO EL CLEARING DE INFORMES<br><br>" +
           "El que suscribe ______________________________ declara que los datos aportados son ciertos y actuales y los informa a los efectos de la contrataci�n de los servicios educativos que el Colegio Nacional Jos� Pedro Varela provee. La actualizaci�n de los datos prove�dos es responsabilidad de la parte.</b>"



    informacion = 
      "El alumno #{nombre_alumno} cuya c�dula es #{cedula_alumno} ha comenzado el proceso de reinscripci�n para el a�o lectivo #{anio} en " + 
      "#{nombre_grado} del Colegio Nacional Jos� Pedro Varela."

    cabezal = 
      "$U <b>#{total}</b>" + 
      "<br><br>" +
      "Lugar y fecha de emisi�n: <b>Montevideo, #{I18n.l(DateTime.now, format: '%-d de %B de %Y')}</b>";

    if cuotas.count==1 && cuotas[0][0] == 1
      texto = "<b>VALE</b>"
    else
      texto = "<b>VALE AMORTIZABLE</b>"
    end

    texto = texto + " por la cantidad de pesos uruguayos <b>#{total_letras}</b> que debo (debemos) y pagar� (pagaremos) en forma " +
      "indivisible y solidaria a la Sociedad Uruguaya de Ense�anza, Colegio Nacional Jos� Pedro Varela - o a su orden, en la misma moneda, en " +
      "#{cuotas_a_letras(cuotas)}, en el domicilio del acreedor sito en la calle Colonia 1637 de la ciudad de Montevideo, o donde indique el acreedor." +
      "<br><br>" + 
      "La falta de pago de dos o m�s cuotas a su vencimiento producir� la mora de pleno derecho sin necesidad de interpelaci�n de clase alguna, " +
      "deveng�ndose por esa sola circunstancias, intereses moratorios del 40% (cuarenta por ciento) tasa efectiva anual (aprobada por BCU) y har� " +
      "exigible la totalidad del monto adeudado m�s los intereses moratorios generados a partir del incumplimiento y hasta su efectiva y total " + 
      "cancelaci�n." +
      "<br><br>" + 
      "En caso de incumplimiento total o parcial del presente t�tulo, el acreedor a su elecci�n, podr� demandar la ejecuci�n de este t�tulo ante " +
      "los Jueces del lugar de residencia del deudor o ante los del lugar del cumplimiento de la obligaci�n." +
      "<br><br>" + 
      "Para todos los efectos judiciales y/o extrajudiciales a que pudiera dar lugar �ste documento, el deudor constituye como domicilio especial el " +
      "abajo denunciado." +
      "<br><br><br>" + 
      "NOMBRE COMPLETO: #{nombreT[0]}<br><br>" +
      "DOCUMENTO DE IDENTIDAD: #{Inscripcion.cedula_tos(documentoT[0])}<br><br>" +
      "DOMICILIO: #{domicilioT[0]}<br><br>" +
      "MAIL: #{emailT[0]}<br><br>" +
      "TEL/CEL: #{celularT[0]}<br><br>" +
      "FIRMA:<br><br>" +
      "Aclaraci�n:<br><br>" +
      "<br><br>" +
      "NOMBRE COMPLETO: #{nombreT[1]}<br><br>" +
      "DOCUMENTO DE IDENTIDAD: #{Inscripcion.cedula_tos(documentoT[1])}<br><br>" +
      "DOMICILIO: #{domicilioT[1]}<br><br>" +
      "MAIL: #{emailT[1]}<br><br>" +
      "TEL/CEL: #{celularT[1]}<br><br>" +
      "FIRMA:<br><br>" +
      "Aclaraci�n:<br><br>";

    text_file = Tempfile.new("text.pdf")
    text_file_path = text_file.path

    reinsc = reinscripcion

    Prawn::Document.generate(text_file_path) do

      if reinsc
        font "Helvetica", :size => 12

        dash 5, space: 0, phase:0
        stroke_color "0000FF"
        stroke_rectangle [0, 720], 540, 520   
        stroke_color "FF0000"
        stroke_rectangle [2, 718], 536, 516

        stroke_color "000000"
        dash 5, space: 5, phase:0
        stroke_horizontal_line -40, 580, at:100


        image Rails.root.join("data", "logo.png"), at: [203,655], scale: 0.5

        bounding_box([20, 455], :width => 500, :height => 60) do
          text titulo, align: :center, inline_format: true
        end

        bounding_box([60, 425], :width => 420, :height => 60) do
          text informacion, align: :center, inline_format: true
        end

        bounding_box([0, 180], :width => 500, :height => 60) do
          text "Recibido por:", align: :left, inline_format: true
        end
        bounding_box([0, 160], :width => 500, :height => 60) do
          text "Fecha:", align: :left, inline_format: true
        end
        bounding_box([0, 60], :width => 500, :height => 60) do
          text "Recibido por:", align: :left, inline_format: true
        end
        bounding_box([0, 40], :width => 500, :height => 60) do
          text "Fecha:", align: :left, inline_format: true
        end

        start_new_page
      end

      if !reinsc
        font "Helvetica", :size => 10
        
        dash 5, space: 0, phase:0
        stroke_color "0000FF"
        stroke_rectangle [0, 720], 540, 720   
        stroke_color "FF0000"
        stroke_rectangle [2, 718], 536, 716

        image Rails.root.join("data", "logo.png"), at: [203,700], scale: 0.5

        bounding_box([20, 570], :width => 500, :height => 300) do
          text texto_inscripcion, align: :left, inline_format: true
        end

        bounding_box([20, 280], :width => 250, :height => 150) do
          text texto_padre, align: :left, inline_format: true
        end

        bounding_box([270, 280], :width => 250, :height => 150) do
          text texto_madre, align: :left, inline_format: true
        end

        bounding_box([20, 120], :width => 500, :height => 120) do
          text texto_nota, align: :justify, inline_format: true
        end

        start_new_page
      end

      font "Helvetica", :size => 10

      dash 5, space: 0, phase:0
      stroke_color "0000FF"
      stroke_rectangle [0, 720], 540, 720   
      stroke_color "FF0000"
      stroke_rectangle [2, 718], 536, 716

      bounding_box([20, 700], :width => 500, :height => 60) do
        text cabezal, align: :right, inline_format: true
      end
      bounding_box([20, 640], :width => 500, :height => 600) do
        text texto, align: :justify, inline_format: true
      end

    end

    pdf = CombinePDF.new
    pdf << CombinePDF.load(text_file_path)
    pdf.save file_path

    text_file.unlink

  end

end