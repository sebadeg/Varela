class CreateRefinanciaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :refinanciaciones do |t|
	  t.belongs_to :cuenta, foreign_key: true
      t.date :fecha
      t.decimal :importe

      t.timestamps
    end
  end
end
