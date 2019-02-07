class Pase < ApplicationRecord
  belongs_to :alumno

  scope :todos, -> { all }
  scope :pases, -> { where("NOT fecha IS NULL") }

end
