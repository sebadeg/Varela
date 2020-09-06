class CreateInscripcion2020s < ActiveRecord::Migration[5.2]
  def change
    create_table :inscripcion2020s do |t|
      t.belongs_to :alumno
      t.belongs_to :padre, :class_name => "Usuario"
      t.belongs_to :madre, :class_name => "Usuario"
      t.belongs_to :titular1, :class_name => "Usuario"
      t.belongs_to :titular2, :class_name => "Usuario"
      t.belongs_to :grado
      t.belongs_to :proximo_grado

      t.boolean :reinscripcion
      t.boolean :inhabilitado
     
      t.date :fecha_comienzo
      t.date :fecha_fin

      t.belongs_to :convenio2020
      t.belongs_to :matricula2020
      t.belongs_to :hermanos2020
      t.belongs_to :cuota2020
      t.belongs_to :adicional2020
      
      t.date :fecha_registrado
      t.date :fecha_vale
      t.date :fecha_descargado
      t.date :fecha_entregado
      t.date :fecha_inscripto

      t.date :fecha_pase
      t.string :destino_pase

      t.timestamps
    end
  end
end
