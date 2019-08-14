class InscripcionOpcion < ApplicationRecord
  belongs_to :inscripcion_opcion_tipo


  def nombre_completo
    s = ""
    if inscripcion_opcion_tipo != nil 
      s = inscripcion_opcion_tipo.nombre + ": "
    end
    s = s + nombre
    return s
  end

end
