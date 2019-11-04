class CreateMatriculaOpciones < ActiveRecord::Migration[5.2]
  def change
    create_table :matricula_opciones do |t|
      t.integer :matricula_id
      t.integer :cuotas
      t.date :fecha

      t.timestamps
    end
  end
end
