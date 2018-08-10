class AddGradoToProximoGrado < ActiveRecord::Migration[5.0]
  def change
    add_column :proximo_grados, :grado, :integer
  end
end
