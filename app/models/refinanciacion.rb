class Refinanciacion < ApplicationRecord
  has_many :refinanciacion_cuota, :dependent => :delete_all
  accepts_nested_attributes_for :refinanciacion_cuota, allow_destroy: true

  belongs_to :cuenta
end
