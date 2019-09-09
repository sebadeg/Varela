class RemoveReferenceConvenioToInscripciones < ActiveRecord::Migration[5.2]
  def change
  	remove_foreign_key :inscripciones, :convenios
  end
end
