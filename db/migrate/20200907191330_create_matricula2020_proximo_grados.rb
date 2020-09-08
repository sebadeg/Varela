class CreateMatricula2020ProximoGrados < ActiveRecord::Migration[5.2]
  def change
    create_table :matricula2020_proximo_grados do |t|
      t.belongs_to :matricula2020
      t.belongs_to :proximo_grado
      t.decimal :precio

      t.timestamps
    end
  end
end
