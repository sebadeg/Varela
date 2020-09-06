class CreateProximoGradoMatricula2020s < ActiveRecord::Migration[5.2]
  def change
    create_table :proximo_grado_matricula2020s do |t|
      t.belongs_to :proximo_grado
      t.belongs_to :matricula2020

      t.timestamps
    end
  end
end
