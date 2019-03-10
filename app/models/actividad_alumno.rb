class ActividadAlumno < ApplicationRecord

  def elegir_opcion(opcion)
  	actividad = Actividad.find(actividad_id)
  	alumno = Alumno.find(alumno_id)

    movs = Movimiento.where("actividad_alumno_id=#{id} AND actividad_alumno_opcion<>#{opcion}") rescue nil
    if ( movs != nil && movs.count != 0 )
      movs.destroy_all
    end

    movs = Movimiento.where("actividad_alumno_id=#{id} AND actividad_alumno_opcion=#{opcion}") rescue nil
    if ( movs == nil || movs.count == 0 )
      cuenta_id = CuentaAlumno.where(alumno_id: alumno_id).first.cuenta_id
      actividad_opcion = ActividadOpcion.find(opcion)
      if actividad_opcion.fecha != nil 
        fecha = DateTime.new(actividad_opcion.fecha.year,actividad_opcion.fecha.month,1)
        if actividad_opcion.cuotas >= 1 
          (1..actividad_opcion.cuotas).each do |cuota|
            Movimiento.create(cuenta_id: cuenta_id, alumno: alumno_id, fecha: fecha + (cuota-1).month,
              descripcion: "#{actividad.nombre.upcase} #{cuota}/#{actividad_opcion.cuotas}" , extra: "", debe: actividad_opcion.importe,
              haber: 0, tipo: 1002, actividad_alumno_id: id, actividad_alumno_opcion: opcion )
          end
        end
      end
    end
  end
end
