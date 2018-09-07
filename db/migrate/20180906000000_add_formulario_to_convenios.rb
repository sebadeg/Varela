class AddFormularioToConvenios < ActiveRecord::Migration[5.0]
  def change
    add_column :convenios, :formulario, :boolean, default: false
  end
end
