class CreateSeguimientos < ActiveRecord::Migration[5.2]
  def change
    create_table :seguimientos do |t|
      t.belongs_to :alumno, foreign_key: true
      t.string :celular
      t.boolean :no_atiende
      t.boolean :no_inscribe
      t.boolean :inscribe
      t.boolean :duda
      t.text :comentario

      t.timestamps
    end
  end
end
