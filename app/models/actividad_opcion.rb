class ActividadOpcion < ApplicationRecord
  def self.opciones(actividad_id)
    opciones = Array.new
    elecciones = Hash.new

    ActividadOpcion.where(["actividad_id=#{actividad_id}"]).order(:indice).each do |opcion|
      if (opcion.fecha >= DateTime.now )
        s = ""
        if opcion.opcion_concepto_id != nil  
          concepto = OpcionConcepto.find(opcion.opcion_concepto_id)
          s = concepto != nil ? concepto.nombre : ""
        end
        if ( opcion.cuotas != nil && opcion.cuotas > 0 )
          if ( opcion.cuotas == 1 )
            s = s + " a debitar contado de $U "
          else
            s = s + " a debitar en #{opcion.cuotas} cuotas de $U "
          end
          s = s + "#{opcion.importe}"
        end
        opciones.push( [s,opcion.id] )
        elecciones[opcion.id] = s
      end
    end

    return { :opciones => opciones, :elecciones => elecciones }
  end
end
