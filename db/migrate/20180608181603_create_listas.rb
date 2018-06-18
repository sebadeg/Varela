class CreateListas < ActiveRecord::Migration[5.0]
  def change
    create_table :listas do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
