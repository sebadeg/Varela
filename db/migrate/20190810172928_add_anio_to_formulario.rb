class AddAnioToFormulario < ActiveRecord::Migration[5.2]
  def change
    add_column :formularios, :anio, :integer
  end
end
