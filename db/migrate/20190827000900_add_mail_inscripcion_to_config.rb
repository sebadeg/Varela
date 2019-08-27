class AddMailInscripcionToConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :configs, :mail_inscripcion, :string
  end
end
