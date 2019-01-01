class AddAnioToGrados < ActiveRecord::Migration[5.2]
  def change
    add_column :grados, :anio, :integer
    add_column :grados, :codigo, :integer
    add_column :grados, :pri_mdeo, :boolean, default: false
    add_column :grados, :sec_mdeo, :boolean, default: false
    add_column :grados, :sec_cc, :boolean, default: false
    add_column :grados, :proximo_grado, :integer
  end
end
