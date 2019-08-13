class CreateConvenioDescuentos < ActiveRecord::Migration[5.2]
  def change
    create_table :convenio_descuentos do |t|
      t.belongs_to :convenio, foreign_key: true
      t.belongs_to :descuento, foreign_key: true

      t.timestamps
    end
  end
end
