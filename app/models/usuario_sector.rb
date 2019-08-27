class UsuarioSector < ApplicationRecord
  belongs_to :admin_usuario
  belongs_to :sector

end
