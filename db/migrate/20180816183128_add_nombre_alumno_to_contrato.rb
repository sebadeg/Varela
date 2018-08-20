class AddNombreAlumnoToContrato < ActiveRecord::Migration[5.0]
  def change
    add_column :contratos, :alumno, :string
  end
end
