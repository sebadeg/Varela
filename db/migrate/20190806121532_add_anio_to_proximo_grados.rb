class AddAnioToProximoGrados < ActiveRecord::Migration[5.2]
  def change
    add_column :proximo_grados, :anio, :integer
  end
end
