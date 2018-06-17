class ListaAlumno < ApplicationRecord
  belongs_to :linea, dependent: :destroy
  belongs_to :alumno
end
