class Factura < ApplicationRecord

    require 'chunky_png'
    require 'barby'
    require 'barby/barcode/code_128'
    #require 'barby/barcode/code_39'
    require 'barby/outputter/png_outputter'

    def imprimir(file_path)

      codigo_barras = '*JP201805527475121210337550020180531003*'


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
        text_box "Factura", :at => [190, 710-2*renglon]
        text_box "Vencimiento", :at => [190, 710-3*renglon]

        text_box "Titular", :at => [280, 710]
        text_box "Cuenta", :at => [280, 710-renglon]
        text_box "Factura", :at => [280, 710-2*renglon]
        text_box "Vencimiento", :at => [280, 710-3*renglon]


        text_box "Total", :at => [200, 145]
        bounding_box([320, 145], :width => 200, :height => renglon) do
          text_box "200000.00", align: :right
          transparent(0) { stroke_bounds }
        end


        text_box "Alumno", :at => [10, 606]
        text_box "Grado", :at => [190, 606]
        text_box "Concepto", :at => [280, 606]
        text_box "Importe", :at => [450, 606]

        # Generate whatever you want here.
        (1..15).each do |x|
          text_box "100", :at => [10, i-x*renglon]
          
        end
        text_box "200", :at => [190, 335]
        text_box "300", :at => [280, 335]

bounding_box([450, 335], :width => 70, :height => renglon) do
 text_box "200000.00", align: :right
 transparent(0) { stroke_bounds }
end



        image barcode_file.path, at: [20, 25]

        text_box codigo_barras, :at => [170, 8], size:8


        text_box "31/05/2018", :at => [325, 106], size:8

        delta=73

        text_box "Emisión", :at => [20, 41], size:8
        text_box "Vencimiento", :at => [20+delta, 41], size:8
        text_box "Documento", :at => [20+2*delta, 41], size:8
        text_box "Cuenta", :at => [20+3*delta, 41], size:8
        text_box "Comprobante", :at => [20+4*delta, 41], size:8
        text_box "Moneda", :at => [20+5*delta, 41], size:8
        text_box "Importe", :at => [20+6*delta, 41], size:8

        text_box "Junio", :at => [20, 33], size:8
        text_box "10/06/2018", :at => [20+delta, 33], size:8
        text_box "Factura", :at => [20+2*delta, 33], size:8
        text_box "12121", :at => [20+3*delta, 33], size:8
        text_box "535452", :at => [20+4*delta, 33], size:8
        text_box "UYU", :at => [20+5*delta, 33], size:8
        text_box "33596.00", :at => [20+6*delta, 33], size:8
      end

      pdf = CombinePDF.new
      pdf << CombinePDF.load(template_file) # one way to combine, very fast.
      pdf.pages.each {|page| page <<  CombinePDF.load(text_file_path).pages[0]}
      pdf.save file_path

	  text_file.unlink
	  barcode_file.unlink

    end
end
