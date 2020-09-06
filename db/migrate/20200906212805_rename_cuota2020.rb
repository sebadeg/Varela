class RenameCuota2020 < ActiveRecord::Migration[5.2]
  def change
	rename_column :cuota2020s, :formulario, :general
  end
end
