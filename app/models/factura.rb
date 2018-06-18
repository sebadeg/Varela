class Factura < ApplicationRecord



    def imprimir(file)
      template_file = Rails.root.join("data", 'factura.pdf')
      text_file = Rails.root.join("tmp", 'text.pdf')
      output_file = Rails.root.join("tmp", 'output.pdf')

      i = 606 
      f = 268

      Prawn::Document.generate(text_file) do
        # Generate whatever you want here.
        (0..15).each do |x|
          text_box "100", :at => [10, i-(i-f)*1.0*x/15]
          
        end
        text_box "200", :at => [190, 335]
        text_box "300", :at => [280, 403]
      end

      pdf = CombinePDF.new
      pdf << CombinePDF.load(template_file) # one way to combine, very fast.
      pdf.pages.each {|page| page <<  CombinePDF.load(text_file).pages[0]}
      pdf.save output_file

    end

end
