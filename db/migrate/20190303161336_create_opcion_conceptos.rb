class CreateOpcionConceptos < ActiveRecord::Migration[5.2]
  def change
    create_table :opcion_conceptos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
