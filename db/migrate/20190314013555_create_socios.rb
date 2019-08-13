class CreateSocios < ActiveRecord::Migration[5.2]
  def change
    create_table :socios do |t|
      t.string :nombre
      t.integer :cedula
      t.string :email
      t.string :domicilio
      t.string :celular

      t.timestamps
    end
  end
end
