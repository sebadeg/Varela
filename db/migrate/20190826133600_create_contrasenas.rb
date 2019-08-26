class CreateContrasenas < ActiveRecord::Migration[5.2]
  def change
    create_table :contrasenas do |t|
      t.string :mail
      t.string :password

      t.timestamps
    end
  end
end
