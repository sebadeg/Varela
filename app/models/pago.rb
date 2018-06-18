class Pago < ApplicationRecord
  has_many :pago_cuenta, :dependent => :delete_all

  require 'tempfile'
  require 'roo'
  #require "simple-spreadsheet"

  def importar(file)

    self.nombre = file.original_filename
    self.data = file.read
    if !self.save 
      return false
    end

    archs = Array.new

    ext = nombre.slice(nombre.rindex("."), nombre.length).downcase;

    file = Tempfile.new(nombre)

    nombre_tmp = file.path

    p nombre_tmp

#    Rails.root.join("data", user.id.to_s + "_" + DateTime.now.strftime('%Y%m%d%H%M%S') + "_" + nombre)
    IO.binwrite(nombre_tmp, data)

    if ext == ".xls"
      s = Roo::Spreadsheet.open(nombre_tmp, extension: :xls )

      if s.sheet(0).row(1)[0] == "Año"
        primera = true
        s.sheet(0).each do |line|
          if !primera
            archs.push( {

#                fecha = Date.strptime(line[9], '%d/%m/%Y')
#                cuenta = line[3].to_i
#                dato = line[4]
#                moneda = line[5]
#                importe = line[6].to_f
#                sucursal = "Sistarbanc: Subagencia " + line[7].to_i.to_s + " Caja " + line[8] + " Movimiento " + line[10] 

                info: line.to_csv(row_sep: ";"),
                fecha: Date.strptime(line[9], '%d/%m/%Y'),
                cuenta: line[3].to_i,
                importe: line[6].to_f,
                dato: line[4],
                moneda: line[5],
                tipo: 'Sistarbanc',
                subagencia: line[7],
                caja: line[8], 
                movimiento: line[10] 
            } )
          end
          primera = false
        end
      elsif s.sheet(0).row(1)[0] == "AÑO"
        primera = true
        s.sheet(0).each do |line|
          if !primera
            archs.push( { 

#                fecha = line[9]
#                cuenta = line[3].to_i
#                dato = line[4]
#                moneda = line[5] == 0.0 ? 'UYU' : ''
#                importe = line[6]
#                sucursal = "Red Pagos: Subagencia " + line[7].to_i.to_s + " Caja " + line[8].to_i.to_s + " Movimiento " + line[10].to_i.to_s 

            	info: line.to_csv(row_sep: ";"), 
            	fecha: line[9],
            	cuenta: line[3].to_i,
            	importe: line[6].to_f,
                dato: line[4], 
                moneda: line[5], 
                tipo: 'Red pagos', 
                subagencia: line[7], 
                caja: line[8], 
                movimiento: line[10]
            } )
          end
          primera = false
        end
      else s.sheet(0).row(1)[0] == "FECHA PAGO"
        primera = true
        s.sheet(0).each do |line|
          if !primera
            archs.push( { 
#                fecha = line[0]
#                dato = line[2] + ',' + line[3]
#                moneda = line[4] == '$' ? 'UYU' : ''
#                importe = line[5]
#                sucursal = "Red Pagos: Subagencia " + line[6].to_i.to_s + " Caja " + line[7].to_i.to_s + " Movimiento " + line[8].to_i.to_s 

            	info: line.to_csv(row_sep: ";"), 
            	fecha: line[0],
            	cuenta: "", 
            	importe: line[5].to_f,
                dato: line[2] + ',' + line[3],
                moneda: line[4],
                tipo: 'Red pagos',
                subagencia: line[6],
                caja: line[7],
                movimiento: line[8] 
            } )
          end
          primera = false
        end
      end
    elsif ext == ".csv" 
      s = File.readlines(nombre_tmp)
      s.each do |line|
        ss = line.encode('UTF-8', invalid: :replace, :undef => :replace, replace: 'X').split(",")
        archs.push( { 

#            fecha = Date.strptime(ss[7], '%d/%m/%Y')
#            cuenta = ss[3].to_i
#            dato = ss[1] + ',' + ss[2]
#            factura = ss[0].to_i
#            moneda = 'UYU'
#            importe = ss[4].to_f/100
#            sucursal = "Abitab: Agencia " + ss[5].to_i.to_s + " Subagencia " + ss[6].to_i.to_s 

        	info: line, 
        	fecha: Date.strptime(ss[7], '%d/%m/%Y'),
        	cuenta: ss[3].to_i, 
        	importe: ss[4].to_f/100,
            dato: ss[1] + ',' + ss[2],
            moneda: "",
            factura: ss[0].to_i,
            tipo: 'Abitab',
            agencia: ss[5],
            subagencia: ss[6]
        } )
      end
    elsif ext == ".txt"
      s = File.readlines(nombre_tmp)

      if s[0][0,2] == "JP"
        s.each do |line|
# #JP201712 489405 13810 00916400 20171231 006 00916400 00113 12122017
# #JP201712489405138100091640020171231006009164000011312122017
          archs.push( { 

#            fecha = Date.strptime(line[51,2]+'-'+line[53,2]+'-'+line[55,4], '%d-%m-%Y')
#            cuenta = line[14,5].to_i
#            factura = line[8,6].to_i
#            moneda = 'UYU'
#            importe = line[19,8].to_f/100
#            sucursal = "Red Pagos: Agencia " + line[46,5].to_i.to_s + " Subagencia " + line[35,3].to_i.to_s 

            info: line, 
            fecha: Date.strptime(line[51,2]+'-'+line[53,2]+'-'+line[55,4], '%d-%m-%Y'),
            cuenta: line[14,5].to_i, 
            importe: line[19,8].to_f/100,
            dato: "",
            moneda: "",
            factura: line[8,6].to_i,
            tipo: 'Red Pagos',
            agencia: line[46,5],
            subagencia: line[35,3]
          } )
        end
      else
# #1D0010017121009980          00450798A0000000000017120000000021110000000000000000RODRIGUEZ ,ALVARO  -Deb.Aut.BROU
        s.each do |line|
          if ( line[0,2] == '1D' )
            archs.push( {

#              fecha = Date.strptime(line[11,2]+'-'+line[9,2]+'-20'+line[7,2], '%d-%m-%Y')
#              cuenta = line[13,5].to_i
#              dato = line[80..(line.length-1)]
#              factura = line[30,6].to_i
#              moneda = 'UYU'
#              importe = line[59,8].to_f/100
#              sucursal = "BROU"

              info: line, 
              fecha: Date.strptime(line[11,2]+'-'+line[9,2]+'-20'+line[7,2], '%d-%m-%Y'),
              cuenta: line[13,5].to_i, 
              importe: line[59,8].to_f/100,
              dato: line[80..(line.length-1)],
              moneda: "",
              factura: line[30,6].to_i,
              tipo: 'BROU'
            } )
          end
        end
      end
    end


    file.unlink

    indice = 0
    archs.each do |arch|
      pagoCuenta = PagoCuenta.find_or_create_by!( pago_id: id, indice: indice )
      cuenta = Cuenta.find(arch[:cuenta]) rescue nil
      if ( cuenta != nil )
        pagoCuenta.cuenta_id = cuenta.id
      else
        factura = Factura(arch[:factura]) rescue nil
        if ( factura != nil )
          pagoCuenta.cuenta_id = factura.cuenta_id
        end
      end
      pagoCuenta.fecha = arch[:fecha]
      pagoCuenta.descripcion = arch.to_s
      pagoCuenta.importe = arch[:importe]
      pagoCuenta.save!

      indice = indice+1
    end
    PagoCuenta.destroy_all( "pago_id=#{id} AND indice>=#{archs.length}")
    return true
  end  
end




#       if ext == ".xls"
#         s = Roo::Spreadsheet.open(nombre, extension: :xls )

#         if s.sheet(0).row(1)[0] == "Año"
#           primera = true
#           s.sheet(0).each do |line|
#             if !primera
#               fecha = Date.strptime(line[9], '%d/%m/%Y')
#               cuenta = line[3].to_i
#               dato = line[4]
#               moneda = line[5]
#               importe = line[6].to_f
#               sucursal = "Sistarbanc: Subagencia " + line[7].to_i.to_s + " Caja " + line[8] + " Movimiento " + line[10] 

#               $archs.push( { name: e.nombre, info: line, fecha: fecha, cuenta: cuenta, dato: dato,
#                     moneda:moneda, importe:importe, sucursal:sucursal } )
#             end
#             primera = false
#           end
#         elsif s.sheet(0).row(1)[0] == "AÑO"
#           primera = true
#           s.sheet(0).each do |line|
#             if !primera
#               fecha = line[9]
#               cuenta = line[3].to_i
#               dato = line[4]
#               moneda = line[5] == 0.0 ? 'UYU' : ''
#               importe = line[6]
#               sucursal = "Red Pagos: Subagencia " + line[7].to_i.to_s + " Caja " + line[8].to_i.to_s + " Movimiento " + line[10].to_i.to_s 

#               $archs.push( { name: e.nombre, info: line, fecha: fecha, cuenta: cuenta, dato: dato,
#                     moneda:moneda, importe:importe, sucursal:sucursal } )
#             end
#             primera = false
#           end
#         else
#           primera = true
#           s.sheet(0).each do |line|
#             if !primera
#               fecha = line[0]
#               dato = line[2] + ',' + line[3]
#               moneda = line[4] == '$' ? 'UYU' : ''
#               importe = line[5]
#               sucursal = "Red Pagos: Subagencia " + line[6].to_i.to_s + " Caja " + line[7].to_i.to_s + " Movimiento " + line[8].to_i.to_s 

#               $archs.push( { name: e.nombre, info: line, fecha: fecha, dato: dato,
#                     moneda:moneda, importe:importe, sucursal:sucursal } )
#             else
#               $archs.push( { name: e.nombre, info: line, sucursal: "Red Pagos" } )
#             end
#             primera = false
#           end
#         end

#       elsif ext == ".csv" 
#         s = File.readlines(nombre)
#         s.each do |line|
#           ss = line.encode('UTF-8', invalid: :replace, :undef => :replace, replace: 'X').split(",")

#           fecha = Date.strptime(ss[7], '%d/%m/%Y')
#           cuenta = ss[3].to_i
#           dato = ss[1] + ',' + ss[2]
#           factura = ss[0].to_i
#           moneda = 'UYU'
#           importe = ss[4].to_f/100
#           sucursal = "Abitab: Agencia " + ss[5].to_i.to_s + " Subagencia " + ss[6].to_i.to_s 

#           $archs.push( { name: e.nombre, info: line, fecha: fecha, cuenta: cuenta, dato: dato,
#                 factura:factura, moneda:moneda, importe:importe, sucursal:sucursal } )
#         end

#       elsif ext == ".txt"
#         s = File.readlines(nombre)

#         if s[0][0,2] == "JP"

#           s.each do |line|
# #JP201712 489405 13810 00916400 20171231 006 00916400 00113 12122017
# #JP201712489405138100091640020171231006009164000011312122017
        
#             fecha = Date.strptime(line[51,2]+'-'+line[53,2]+'-'+line[55,4], '%d-%m-%Y')
#             cuenta = line[14,5].to_i
#             factura = line[8,6].to_i
#             moneda = 'UYU'
#             importe = line[19,8].to_f/100
#             sucursal = "Red Pagos: Agencia " + line[46,5].to_i.to_s + " Subagencia " + line[35,3].to_i.to_s 

#             $archs.push( { name: e.nombre, info: line, fecha: fecha, cuenta: cuenta, dato: '',
#                   factura:factura, moneda:moneda, importe:importe, sucursal:sucursal } )

#           end
#         else

# #1D0010017121009980          00450798A0000000000017120000000021110000000000000000RODRIGUEZ ,ALVARO  -Deb.Aut.BROU
#           s.each do |line|
#             if ( line[0,2] == '1D' )

#               fecha = Date.strptime(line[11,2]+'-'+line[9,2]+'-20'+line[7,2], '%d-%m-%Y')
#               cuenta = line[13,5].to_i
#               dato = line[80..(line.length-1)]
#               factura = line[30,6].to_i
#               moneda = 'UYU'
#               importe = line[59,8].to_f/100
#               sucursal = "BROU"

#               $archs.push( { name: e.nombre, info: line, fecha: fecha, cuenta: cuenta, dato: dato,
#                     factura:factura, moneda:moneda, importe:importe, sucursal:sucursal } )
#             else
#               #$archs.push( { name: e.nombre, info: line, sucursal:'BROU Nada' } )

#             end
#           end
#         end
#       end 
