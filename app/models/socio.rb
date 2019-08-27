class Socio < ApplicationRecord

  scope :todos, -> { all }
  scope :activos, -> { where("fecha_egreso IS NULL AND (fecha_ingreso <= now() - interval '2 years')") }
  scope :suscriptores, -> { where("fecha_egreso IS NULL AND (fecha_ingreso > now() - interval '2 years')") }

end
