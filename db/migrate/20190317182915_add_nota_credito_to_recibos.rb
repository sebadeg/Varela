class AddNotaCreditoToRecibos < ActiveRecord::Migration[5.2]
  def change
    add_column :lote_recibos, :nota_credito, :boolean, default: :false
  end
end
