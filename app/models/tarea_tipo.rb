class TareaTipo < ApplicationRecord
  has_many :tarea, :dependent => :delete_all
  accepts_nested_attributes_for :tarea, allow_destroy: true
end
