class AddDatosToInscripciones < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripciones, :lugar_nacimiento, :string
    add_column :inscripciones, :fecha_nacimiento, :date
    add_column :inscripciones, :domicilio, :string
    add_column :inscripciones, :celular, :string
    add_column :inscripciones, :mutualista, :string
    add_column :inscripciones, :emergencia, :string
    add_column :inscripciones, :procede, :string

    add_column :inscripciones, :nombre_padre, :string
    add_column :inscripciones, :apellido_padre, :string
    add_column :inscripciones, :lugar_nacimiento_padre, :string
    add_column :inscripciones, :fecha_nacimiento_padre, :date
    add_column :inscripciones, :email_padre, :string
    add_column :inscripciones, :domicilio_padre, :string
    add_column :inscripciones, :celular_padre, :string
    add_column :inscripciones, :profesion_padre, :string
    add_column :inscripciones, :trabajo_padre, :string
    add_column :inscripciones, :telefono_trabajo_padre, :string
    add_column :inscripciones, :titular_padre, :boolean

    add_column :inscripciones, :nombre_madre, :string
    add_column :inscripciones, :apellido_madre, :string
    add_column :inscripciones, :lugar_nacimiento_madre, :string
    add_column :inscripciones, :fecha_nacimiento_madre, :date
    add_column :inscripciones, :email_madre, :string
    add_column :inscripciones, :domicilio_madre, :string
    add_column :inscripciones, :celular_madre, :string
    add_column :inscripciones, :profesion_madre, :string
    add_column :inscripciones, :trabajo_madre, :string
    add_column :inscripciones, :telefono_trabajo_madre, :string
    add_column :inscripciones, :titular_madre, :boolean

    add_column :inscripciones, :fecha, :date
    add_column :inscripciones, :recibida, :string
  end
end
