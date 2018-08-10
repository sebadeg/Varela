class CreateConvenios < ActiveRecord::Migration[5.0]
  def change
    create_table :convenios do |t|
      t.string :nombre
      t.decimal :valor

      t.timestamps
    end
  end
end
