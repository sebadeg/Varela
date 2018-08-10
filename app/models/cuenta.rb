class Cuenta < ApplicationRecord

	def movimientos

		sql=
			"SELECT * FROM " +
			"(SELECT facturas.cuenta_id as cuenta_id, facturas.fecha as fecha, linea_facturas.indice as indice, linea_facturas.descripcion as descripcion, linea_facturas.importe as debe, 0 as haber FROM linea_facturas INNER JOIN facturas ON linea_facturas.factura_id=facturas.id " +
			"WHERE saldo AND cuenta_id = #{id} " +
			"UNION " +
			"SELECT cuenta_id, fecha, 1000 as indice,'Pago' as descripcion,0 as debe,importe as haber FROM pago_cuentas " +
			"WHERE cuenta_id = #{id} " +
			"UNION " +
			"SELECT cuenta_id, fecha, 1000 as indice,'Pago' as descripcion,0 as debe,haber as haber FROM movimientos WHERE cuenta_id = #{id} AND descripcion='Pago' AND pago_cuenta_id IS NULL ) AS movimientos " +
			"ORDER BY cuenta_id, fecha, indice";

      	return ActiveRecord::Base.connection.execute(sql)

	end

end
