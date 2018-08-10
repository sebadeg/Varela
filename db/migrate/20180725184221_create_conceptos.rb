class CreateConceptos < ActiveRecord::Migration[5.0]
  def change
    create_table :conceptos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
