class CreateRecargos < ActiveRecord::Migration[5.2]
  def change
    create_table :recargos do |t|
      t.belongs_to :cuenta, foreign_key: true
      t.boolean :recargo
      t.text :comentario

      t.timestamps
    end
  end
end
