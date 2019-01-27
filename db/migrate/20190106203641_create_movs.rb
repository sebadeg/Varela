class CreateMovs < ActiveRecord::Migration[5.2]
  def change
    create_table :movs do |t|
      t.belongs_to :placta, foreign_key: true
      t.integer :movgru
      t.integer :movcap
      t.integer :movrub
      t.integer :movsub
      t.bigint :movcta
      t.date :movfec
      t.integer :movord
      t.datetime :movnow
      t.integer :movcgr
      t.string :movcajpen
      t.integer :movcmx
      t.bigint :movasi
      t.integer :movcom
      t.string :movdes
      t.date :movvto
      t.integer :movcod
      t.decimal :movdeb
      t.decimal :movhab
      t.decimal :movmed
      t.decimal :movmeh
      t.bigint :movcta1
      t.string :movnom
      t.string :movnompla
      t.bigint :movcta2
      t.string :movmov
      t.bigint :movint

      t.timestamps
    end
  end
end
