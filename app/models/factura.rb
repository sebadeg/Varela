class Factura < ApplicationRecord

    require 'chunky_png'
    require 'barby'
    require 'barby/barcode/code_128'
    #require 'barby/barcode/code_39'
    require 'barby/outputter/png_outputter'

    def imprimir(file_path,cuenta_id,factura)

      codigo_barras = 
        '*JP' + factura.fecha.strftime('%Y%m') + 
        factura.id.to_s + cuenta_id.to_s.rjust(5,'0') + 
        (factura.total * 100).to_i.to_s.rjust(8,'0') +
        factura.fecha_vencimiento.strftime('%Y%m%d') + '000*'


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
end
