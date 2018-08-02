class Factura < ApplicationRecord

    require 'chunky_png'
    require 'barby'
    require 'barby/barcode/code_128'
    #require 'barby/barcode/code_39'
    require 'barby/outputter/png_outputter'

    def digito(s)
      suma = 0
      arr = [6,3,4,4,5,6,3,2,7,3,2,9,8,7,
             6,3,4,4,5,6,3,2,7,3,2,9,8,7,
             6,3,4,4,5,6,3,2,7,3,2,9,8,7,
             6,3,4]
      suma = 0
      (0..(arr.count-1)).each do |i|
        suma = suma + s[i,1].to_i * arr[i]
      end
      return (10-(suma%10))%10
    end

    def imprimir(file_path,cuenta_id,factura)

      s = factura.fecha.strftime('%Y%m') + 
        factura.id.to_s + cuenta_id.to_s.rjust(5,'0') + 
        (factura.total * 100).to_i.to_s.rjust(8,'0') +
        factura.fecha_vencimiento.strftime('%Y%m%d') + '00'
      
      dig = digito(s).to_s

      codigo_barras = '*JP' + s + dig + '*'


      usuario = Usuario.where("id IN (SELECT usuario_id FROM titular_cuentas WHERE cuenta_id=#{cuenta_id})").first!
      lineas = LineaFactura.where( "factura_id=#{factura.id}" ).order(:indice)


   	  text_file = Tempfile.new("text.pdf")
 	    text_file_path = text_file.path
      template_file = Rails.root.join("data", 'factura.pdf')

      i = 606 
      f = 268

      renglon = (i-f)*1.0/15

      barcode = Barby::Code128B.new(codigo_barras)
      #barcode = Barby::Code39.new(codigo_barras, true)

 	    barcode_file = Tempfile.new("barcode.png")
        File.open(barcode_file.path, 'wb') do |f|
		    f.write barcode.to_png(:height => 15, :margin => 0)
	    end

      Prawn::Document.generate(text_file_path) do

        text_box "Titular", :at => [190, 710]
        text_box "Cuenta", :at => [190, 710-renglon]
        text_box "Comprobante", :at => [190, 710-2*renglon]
        text_box "Vencimiento", :at => [190, 710-3*renglon]

        text_box usuario.nombre + ' ' + usuario.apellido, :at => [280, 710]
        text_box cuenta_id.to_s, :at => [280, 710-renglon]
        text_box factura.id.to_s, :at => [280, 710-2*renglon]
        text_box factura.fecha_vencimiento.strftime('%d/%m/%Y'), :at => [280, 710-3*renglon]

        text_box "Alumno", :at => [10, 606]
        text_box "Grado", :at => [190, 606]
        text_box "Concepto", :at => [280, 606]
        text_box "Importe", :at => [450, 606]

        # Generate whatever you want here.
        indice = 1
        lineas.each do |linea|

          text_box linea.nombre_alumno, :at => [10, i-indice*renglon]
          text_box "", :at => [190, i-indice*renglon]
          text_box linea.descripcion, :at => [280, i-indice*renglon]

          bounding_box([450, i-indice*renglon], :width => 70, :height => renglon) do
           text_box linea.importe.to_s, align: :right
           transparent(0) { stroke_bounds }
          end

          indice = indice+1          
        end

        text_box "Total", :at => [200, 145]
        bounding_box([320, 145], :width => 200, :height => renglon) do
          text_box factura.total.to_s, align: :right
          transparent(0) { stroke_bounds }
        end

        image barcode_file.path, at: [20, 25]

        text_box codigo_barras, :at => [170, 8], size:8

        text_box (factura.fecha - 1.days).strftime('%d/%m/%Y'), :at => [325, 106], size:8

        delta=73

        text_box "Emisión", :at => [20, 41], size:8
        text_box "Vencimiento", :at => [20+delta, 41], size:8
        text_box "Documento", :at => [20+2*delta, 41], size:8
        text_box "Cuenta", :at => [20+3*delta, 41], size:8
        text_box "Comprobante", :at => [20+4*delta, 41], size:8
        text_box "Moneda", :at => [20+5*delta, 41], size:8
        text_box "Importe", :at => [20+6*delta, 41], size:8

        text_box I18n.l(factura.fecha, format: '%B'), :at => [20, 33], size:8
        text_box factura.fecha_vencimiento.strftime('%d/%m/%Y'), :at => [20+delta, 33], size:8
        text_box "Factura", :at => [20+2*delta, 33], size:8
        text_box cuenta_id.to_s, :at => [20+3*delta, 33], size:8
        text_box factura.id.to_s, :at => [20+4*delta, 33], size:8
        text_box "UYU", :at => [20+5*delta, 33], size:8
        text_box factura.total.to_s , :at => [20+6*delta, 33], size:8
      end

      pdf = CombinePDF.new
      pdf << CombinePDF.load(template_file) # one way to combine, very fast.
      pdf.pages.each {|page| page <<  CombinePDF.load(text_file_path).pages[0]}
      pdf.save file_path

	    text_file.unlink
	    barcode_file.unlink

    end

    def numero_a_letras(n, uno)
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

    def vale(file_path,inscripcionAlumno_id)

      inscripcionAlumno = InscripcionAlumno.find(inscripcionAlumno_id)

      convenio = Convenio.find(inscripcionAlumno.convenio_id)


      importe_total = ProximoGrado.find_by(id: inscripcionAlumno.grado).precio 

      importe_total = importe_total * ( 100 - convenio.valor ) / 100
      if  (inscripcionAlumno.hermanos == 1 )
        importe_total = importe_total * 0.95
      elsif  (inscripcionAlumno.hermanos == 2 )
        importe_total = importe_total * 0.9
      end
      importe_total = (importe_total + 0.5).to_i

      importe_letras = numero_a_letras(importe_total,true)
      cuotas = inscripcionAlumno.cuotas
      importe_cuota = (importe_total/cuotas+0.5).to_i

      if ( inscripcionAlumno.mes == 12 )
        desde = DateTime.new(2018,12,10)
        anio = 2018
      else
        desde = DateTime.new(2019,inscripcionAlumno.mes,10)
        anio = 2019
      end

      mes = I18n.l(DateTime.new(2018,12,10), format: '%B')

      hoy = DateTime.now
      hoyS = "#{hoy.day} de #{hoy.month} de #{hoy.year}"

      cabezal = 
        "$U <b>#{importe_total}</b>" + 
        "<br><br>" +
        "Lugar y fecha de emisión: <b>Montevideo, #{I18n.l(DateTime.now, format: '%-d de %B de %Y')}</b>";
      texto =
        "<b>VALE AMORTIZABLE</b> por la cantidad de pesos uruguayos <b>#{importe_letras}</b> que debo (debemos) y pagaré (pagaremos) en forma indivisible y solidaria a la Sociedad Uruguaya de Enseñanza, Colegio Nacional José Pedro Varela - o a su orden, en la misma moneda, en <b>#{cuotas}</b> cuotas mensuales, iguales y consecutivas de $U <b>#{importe_cuota}</b> cada una, venciendo la primera el día 10 de <b>#{mes}</b> del <b>#{anio}</b>, en el domicilio del acreedor sito en la calle Colonia 1637 de la ciudad de Montevideo, o donde indique el acreedor." +
        "<br><br>" + 
        "La falta de pago de dos o más cuotas a su vencimiento producirá la mora de pleno derecho sin necesidad de interpelación de clase alguna, devengándose por esa sola circunstancias, intereses moratorios del 40% (cuarenta por ciento) tasa efectiva anual (aprobada por BCU) y hará exigible la totalidad del monto adeudado más los intereses moratorios generados a partir del incumplimiento y hasta su efectiva y total cancelación." +
        "<br><br>" + 
        "En caso de incumplimiento total o parcial del presente título, el acreedor a su elección, podrá demandar la ejecución de este título ante los Jueces del lugar de residencia del deudor o ante los del lugar del cumplimiento de la obligación." +
        "<br><br>" + 
        "Para todos los efectos judiciales y/o extrajudiciales a que pudiera dar lugar éste documento, el deudor constituye como domicilio especial el abajo denunciado." +
        "<br><br><br>" + 
        "NOMBRE COMPLETO: #{inscripcionAlumno.nombre1}<br><br>" +
        "DOCUMENTO DE IDENTIDAD: #{inscripcionAlumno.documento1}<br><br>" +
        "DOMICILIO: #{inscripcionAlumno.domicilio1}<br><br>" +
        "MAIL: #{inscripcionAlumno.email1}<br><br>" +
        "TEL/CEL: #{inscripcionAlumno.celular1}<br><br>" +
        "FIRMA:<br><br>" +
        "Aclaración:<br><br>" +
        "<br><br>" +
        "NOMBRE COMPLETO: #{inscripcionAlumno.nombre2}<br><br>" +
        "DOCUMENTO DE IDENTIDAD: #{inscripcionAlumno.documento2}<br><br>" +
        "DOMICILIO: #{inscripcionAlumno.domicilio2}<br><br>" +
        "MAIL: #{inscripcionAlumno.email2}<br><br>" +
        "TEL/CEL: #{inscripcionAlumno.celular2}<br><br>" +
        "FIRMA:<br><br>" +
        "Aclaración:<br><br>";


      text_file = Tempfile.new("text.pdf")
      text_file_path = text_file.path





      Prawn::Document.generate(text_file_path) do

        stroke_color "0000FF"
        stroke_rectangle [0, 720], 540, 720   
        stroke_color "FF0000"
        stroke_rectangle [2, 718], 536, 716

        # bounding_box([0, 0], :width => 200, :height => 200) do
        #   text_box "Prueba", align: :right
        #   transparent(0) { stroke_bounds }
        # end

        font "Helvetica", :size => 10

        bounding_box([20, 700], :width => 500, :height => 60) do
          text cabezal, align: :right, inline_format: true
          #transparent(0) { stroke_bounds }
        end
        bounding_box([20, 640], :width => 500, :height => 600) do
          text texto, align: :justify, inline_format: true
          #transparent(0) { stroke_bounds }
        end



# La falta de pago de dos o más cuotas a su vencimiento producirá la mora de pleno derecho sin necesidad de interpelación de
# clase alguna, devengándose por esa sola circunstancias, intereses moratorios del 40% (cuarenta por ciento) tasa efectiva anual
# (aprobada por BCU) y hará exigible la totalidad del monto adeudado más los intereses moratorios generados a partir del
# incumplimiento y hasta su efectiva y total cancelación.
# En caso de incumplimiento total o parcial del presente título, el acreedor a su elección, podrá demandar la ejecución de este
# título ante los Jueces del lugar de residencia del deudor o ante los del lugar del cumplimiento de la obligación.
# Para todos los efectos judiciales y/o extrajudiciales a que pudiera dar lugar éste documento, el deudor constituye como
# domicilio especial el abajo denunciado.


      end

      pdf = CombinePDF.new
      pdf << CombinePDF.load(text_file_path)
      pdf.save file_path

      text_file.unlink

    end

end
