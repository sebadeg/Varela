class CreateGrados < ActiveRecord::Migration[5.0]
  def change
    create_table :grados do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
