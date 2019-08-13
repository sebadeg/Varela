class AddAnioPasesToConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :configs, :anio_pases, :integer
  end
end
