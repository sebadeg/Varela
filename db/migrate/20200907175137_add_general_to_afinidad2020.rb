class AddGeneralToAfinidad2020 < ActiveRecord::Migration[5.2]
  def change
    add_column :afinidad2020s, :general, :boolean
  end
end
