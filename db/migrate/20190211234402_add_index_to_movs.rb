class AddIndexToMovs < ActiveRecord::Migration[5.2]
  def change
  	add_index :movs, [:movcta, :movfec], :name => 'index_movs_fec'
  	add_index :movs, [:movgru, :movcap, :movrub, :movsub], :name => 'index_movs_cta'
  	#remove_index :movs, :name => 'index_movs'
  end
end
