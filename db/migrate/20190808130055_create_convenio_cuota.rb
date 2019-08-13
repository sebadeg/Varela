class CreateConvenioCuota < ActiveRecord::Migration[5.2]
  def change
    create_table :convenio_cuota do |t|
      t.belongs_to :convenio, foreign_key: true
      t.date :fecha
      t.decimal :importe

      t.timestamps
    end
  end
end
