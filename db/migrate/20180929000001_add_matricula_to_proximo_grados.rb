class AddMatriculaToProximoGrados < ActiveRecord::Migration[5.0]
  def change
    add_column :proximo_grados, :matricula, :decimal
  end
end
