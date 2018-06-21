class CreateCodigos < ActiveRecord::Migration[5.0]
  def change
    create_table :codigos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
