class AddInscriptoToSubgradoAlumnos < ActiveRecord::Migration[5.2]
  def change
    add_column :subgrado_alumnos, :inscripto, :boolean, default: false
  end
end
