class CreateRefinanciacionCuotas < ActiveRecord::Migration[5.2]
  def change
    create_table :refinanciacion_cuotas do |t|
	  t.belongs_to :refinanciacion, foreign_key: true
      t.date :fecha
      t.integer :cantidad
      t.decimal :importe

      t.timestamps
    end
  end
end
