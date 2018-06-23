class AddIndiceToEspecialAlumno < ActiveRecord::Migration[5.0]
  def change
  	add_column :especial_alumnos, :indice, :integer
  	add_index :especial_alumnos, [:especial_id,:indice], unique: true
  end

  
end
