class PagoCuenta < ApplicationRecord

  scope :todos, -> { all }
  scope :sin_cuenta, -> { where(cuenta_id: nil) }

end
