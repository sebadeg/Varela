class Lista < ApplicationRecord
  has_many :lista_alumno, :dependent => :destroy
  accepts_nested_attributes_for :lista_alumno, allow_destroy: true
end
