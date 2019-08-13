class AddCreadaToActividades < ActiveRecord::Migration[5.2]
  def change
    add_column :actividades, :creada, :string
  end
end
