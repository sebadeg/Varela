class Factura < ApplicationRecord

    # require 'chunky_png'
    # require 'barby'
    # require 'barby/barcode/code_128'
    # require 'barby/barcode/code_39'
    # require 'barby/outputter/png_outputter'

    def imprimir(file_path)

 	 #  text_file = Tempfile.new("text.pdf")
 	 #  text_file_path = text_file.path
   #    template_file = Rails.root.join("data", 'factura.pdf')

   #    i = 606 
   #    f = 268

   #    #barcode = Barby::Code128B.new('*JP201805527475121210337550020180531003*')
   #    barcode = Barby::Code39.new('*JP201805527475121210337550020180531003*', true)

 	 #  barcode_file = Tempfile.new("barcode.png")
   #    File.open(barcode_file.path, 'wb') do |f|
		 #  f.write barcode.to_png(:height => 15, :margin => 0)
	  # end

   #    Prawn::Document.generate(text_file_path) do
   #      # Generate whatever you want here.
   #      (0..15).each do |x|
   #        text_box "100", :at => [10, i-(i-f)*1.0*x/15]
          
   #      end
   #      text_box "200", :at => [190, 335]
   #      #text_box "300", :at => [280, 403]

   #      image barcode_file.path, at: [20, 20]
		
   #    end

   #    pdf = CombinePDF.new
   #    pdf << CombinePDF.load(template_file) # one way to combine, very fast.
   #    pdf.pages.each {|page| page <<  CombinePDF.load(text_file_path).pages[0]}
   #    pdf.save file_path

	  # text_file.unlink
	  # barcode_file.unlink

    end
end
