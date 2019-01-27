class CreatePlactas < ActiveRecord::Migration[5.2]
  def change
    create_table :plactas do |t|
      t.integer :plagru
      t.integer :placap
      t.integer :plarub
      t.integer :plasub
      t.bigint :placta
      t.integer :moncod
      t.string :planom
      
      t.timestamps
    end
  end
end
