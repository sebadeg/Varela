class AddMailToActividades < ActiveRecord::Migration[5.2]
  def change
    add_column :actividades, :mail, :boolean
  end
end
