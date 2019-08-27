class LoteRecibo < ApplicationRecord

  has_many :recibo, :dependent => :delete_all
  accepts_nested_attributes_for :recibo, allow_destroy: true

	belongs_to :cuenta

    def fecha_tos(fecha)
      
    end

    def fechavto_tos(fecha)
      if ( fecha == nil )
        return ""
      end
      return 
    end


    def imprimir(file_path)

      lote_recibo = LoteRecibo.find(id)

      text_file = Tempfile.new("text.pdf")
      text_file_path = text_file.path

      fec = (lote_recibo.fecha == nil ? "" : I18n.l(lote_recibo.fecha, format: '%-d de %B de %Y'))

      nombre_cuenta = lote_recibo.cuenta_id.to_s;
      cuenta = Cuenta.find(lote_recibo.cuenta_id)
      if cuenta != nil 
        nombre_cuenta = nombre_cuenta + " - " + cuenta.nombre
      end

      if !lote_recibo.nota_credito
        nombre_recibo = "<b>RECIBO</b>"
      else
        nombre_recibo = "<b>NOTA DE CRÉDITO</b>"
      end

      Prawn::Document.generate(text_file_path) do
      	
        # stroke_color "000000"
        # stroke_rectangle [0, 720], 540, 190
        # stroke_rectangle [0, 455], 540, 190
        # stroke_rectangle [0, 190], 540, 190

        #dash(0.25, :space => 0.25, :phase => 0)
        #stroke_horizontal_line 0, 540, :at => 492
        #stroke_horizontal_line 0, 540, :at => 227


        [0,265,530].each do |x|
      
          font "Helvetica", :size => 5

          if x != 530 
            image Rails.root.join("data", "logo.png"), at: [38,x+190], scale: 0.1


            bounding_box([0, x+160], :width => 105, :height => 5) do
              text "Sociedad Uruguaya de Enseñanza", align: :center, inline_format: true
            end
            bounding_box([0, x+152], :width => 105, :height => 5) do
              text "COLEGIO NACIONAL JOSÉ PEDRO VARELA", align: :center, inline_format: true
            end
          end

          font "Helvetica", :size => 8

          bounding_box([210, x+151], :width => 120, :height => 10) do
            text nombre_recibo, align: :center, inline_format: true
          end

          if x == 530
            bounding_box([405, x+151], :width => 135, :height => 10) do
              text "<b>ORIGINAL</b>", align: :right, inline_format: true
            end
          else
            bounding_box([405, x+151], :width => 135, :height => 10) do
              text "<b>DUPLICADO</b>", align: :right, inline_format: true
            end
          end

          bounding_box([0, x+137], :width => 540, :height => 10) do
            text "<b>Comprobante Nro.:</b> #{lote_recibo.id}", align: :right, inline_format: true
          end

          bounding_box([0, x+123], :width => 540, :height => 10) do
            text "<b>Cuenta:</b> #{nombre_cuenta}", align: :left, inline_format: true
          end

          bounding_box([270, x+123], :width => 270, :height => 10) do
            text "Montevideo, #{fec}", align: :right, inline_format: true
          end

          bounding_box([0, x+109], :width => 540, :height => 10) do
            text "<b>Recibimos de:</b> #{lote_recibo.nombre}", align: :left, inline_format: true
          end

          bounding_box([0, x+95], :width => 540, :height => 10) do
            text "<b>La suma de:</b> #{lote_recibo.suma}", align: :left, inline_format: true
          end

          bounding_box([0, x+81], :width => 540, :height => 10) do
            text "<b>Por concepto de:</b> #{lote_recibo.concepto}", align: :left, inline_format: true
          end

          importe = 0
          xx = x+67
          Recibo.where("lote_recibo_id=#{lote_recibo.id}").each do |recibo|

	          bounding_box([0, xx], :width => 135, :height => 10) do
	            text "<b>Cheque Nro.:</b> #{recibo.cheque}", align: :left, inline_format: true
	          end

	          bounding_box([135, xx], :width => 135, :height => 10) do
	            text "<b>Banco:</b> #{recibo.banco}", align: :left, inline_format: true
	          end

            fec_vto = (recibo.fecha_vto == nil ? "" : I18n.l(recibo.fecha_vto, format: '%d/%m/%Y'))
	          bounding_box([270, xx], :width => 135, :height => 10) do
	            text "<b>Vto.:</b> #{fec_vto}", align: :left, inline_format: true
	          end

	          bounding_box([405, xx], :width => 135, :height => 10) do
	            text "<b>$</b> #{recibo.importe}", align: :left, inline_format: true
	          end

            importe = importe + recibo.importe

	          xx = xx - 14
          end

          bounding_box([0, xx], :width => 540, :height => 10) do
            text "<b>Son: $</b> #{importe}", align: :left, inline_format: true
          end

          #font "Helvetica", :size => 10
          #bounding_box([460, x+10], :width => 80, :height => 10) do
          #  text "<b>N°</b> #{recibo.hoja_nro}" , align: :right, inline_format: true
          #end
        end

    #   stroke_color "FF0000"
    #   stroke_rectangle [2, 718], 536, 716

    #   image Rails.root.join("data", "logo.png"), at: [203,700], scale: 0.5

    #   bounding_box([20, 570], :width => 500, :height => 300) do
    #     text texto_inscripcion, align: :left, inline_format: true
    #   end

    #   bounding_box([20, 280], :width => 250, :height => 150) do
    #     text texto_padre, align: :left, inline_format: true
    #   end

    #   bounding_box([270, 280], :width => 250, :height => 150) do
    #     text texto_madre, align: :left, inline_format: true
    #   end

    #   bounding_box([20, 120], :width => 500, :height => 120) do
    #     text texto_nota, align: :justify, inline_format: true
    #   end

    # start_new_page

    #   font "Helvetica", :size => 10

    #   stroke_color "0000FF"
    #   stroke_rectangle [0, 720], 540, 720   
    #   stroke_color "FF0000"
    #   stroke_rectangle [2, 718], 536, 716

    #   bounding_box([20, 700], :width => 500, :height => 60) do
    #     text cabezal, align: :right, inline_format: true
    #   end
    #   bounding_box([20, 640], :width => 500, :height => 600) do
    #     text texto, align: :justify, inline_format: true
    #   end

      end

      pdf = CombinePDF.new
      pdf << CombinePDF.load(text_file_path)
      pdf.save file_path
      text_file.unlink

    end

end
