class CreateAactividades < ActiveRecord::Migration[5.2]
  def change
    create_table :aactividades do |t|
      t.string :nombre
      t.date :fecha
      t.date :fechainfo

      t.timestamps
    end
  end
end
