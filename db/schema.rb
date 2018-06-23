# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180623022205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "actividad_alumnos", force: :cascade do |t|
    t.integer  "actividad_id"
    t.integer  "alumno_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "opcion"
    t.index ["actividad_id"], name: "index_actividad_alumnos_on_actividad_id", using: :btree
    t.index ["alumno_id"], name: "index_actividad_alumnos_on_alumno_id", using: :btree
  end

  create_table "actividad_listas", force: :cascade do |t|
    t.integer  "actividad_id"
    t.integer  "lista_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["actividad_id"], name: "index_actividad_listas_on_actividad_id", using: :btree
    t.index ["lista_id"], name: "index_actividad_listas_on_lista_id", using: :btree
  end

  create_table "actividad_opciones", force: :cascade do |t|
    t.integer  "actividad_id"
    t.integer  "valor"
    t.string   "opcion"
    t.string   "eleccion"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "cuotas"
    t.decimal  "importe"
    t.date     "fecha"
    t.index ["actividad_id"], name: "index_actividad_opciones_on_actividad_id", using: :btree
  end

  create_table "actividades", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "descripcion"
    t.string   "archivo"
    t.date     "fecha"
    t.date     "fechainfo"
    t.binary   "data"
  end

  create_table "admin_usuarios", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "soporte",                default: false
    t.boolean  "primaria",               default: false
    t.boolean  "sec_mdeo",               default: false
    t.boolean  "sec_cc",                 default: false
    t.boolean  "administracion",         default: false
    t.index ["email"], name: "index_admin_usuarios_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_usuarios_on_reset_password_token", unique: true, using: :btree
  end

  create_table "alumnos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "apellido"
  end

  create_table "archivos", force: :cascade do |t|
    t.string   "nombre"
    t.binary   "data"
    t.string   "md5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "codigos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuenta_alumnos", force: :cascade do |t|
    t.integer  "cuenta_id"
    t.integer  "alumno_id"
    t.integer  "numero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_cuenta_alumnos_on_alumno_id", using: :btree
    t.index ["cuenta_id"], name: "index_cuenta_alumnos_on_cuenta_id", using: :btree
  end

  create_table "cuentas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "especial_alumnos", force: :cascade do |t|
    t.integer  "especial_id"
    t.integer  "alumno_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "indice"
    t.index ["alumno_id"], name: "index_especial_alumnos_on_alumno_id", using: :btree
    t.index ["especial_id", "indice"], name: "index_especial_alumnos_on_especial_id_and_indice", unique: true, using: :btree
    t.index ["especial_id"], name: "index_especial_alumnos_on_especial_id", using: :btree
  end

  create_table "especial_cuentas", force: :cascade do |t|
    t.integer  "especial_id"
    t.integer  "cuenta_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["cuenta_id"], name: "index_especial_cuentas_on_cuenta_id", using: :btree
    t.index ["especial_id"], name: "index_especial_cuentas_on_especial_id", using: :btree
  end

  create_table "especiales", force: :cascade do |t|
    t.date     "fecha_comienzo"
    t.date     "fecha_fin"
    t.string   "descripcion"
    t.decimal  "importe"
    t.string   "nombre"
    t.binary   "data"
    t.string   "md5"
    t.boolean  "procesado"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "codigo_id"
    t.index ["codigo_id"], name: "index_especiales_on_codigo_id", using: :btree
  end

  create_table "evento_usuarios", force: :cascade do |t|
    t.string   "nombres"
    t.string   "apellidos"
    t.string   "telefono"
    t.string   "celular"
    t.string   "direccion"
    t.date     "nacimiento"
    t.string   "nacionalidad"
    t.string   "email"
    t.string   "horarios"
    t.boolean  "universidad_completa"
    t.boolean  "universidad_incompleta"
    t.string   "trabajo"
    t.string   "ultimo_trabajo"
    t.string   "comentarios"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "facturas", force: :cascade do |t|
    t.integer  "cuenta_id"
    t.date     "fecha"
    t.decimal  "total"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.date     "fecha_vencimiento"
    t.index ["cuenta_id"], name: "index_facturas_on_cuenta_id", using: :btree
  end

  create_table "grado_alumnos", force: :cascade do |t|
    t.integer  "grado_id"
    t.integer  "alumno_id"
    t.integer  "anio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_grado_alumnos_on_alumno_id", using: :btree
    t.index ["grado_id"], name: "index_grado_alumnos_on_grado_id", using: :btree
  end

  create_table "grados", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "linea_facturas", force: :cascade do |t|
    t.integer  "factura_id"
    t.integer  "alumno_id"
    t.string   "nombre_alumno"
    t.integer  "indice"
    t.string   "descripcion"
    t.decimal  "importe"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["alumno_id"], name: "index_linea_facturas_on_alumno_id", using: :btree
    t.index ["factura_id", "indice"], name: "index_linea_facturas_on_factura_id_and_indice", unique: true, using: :btree
    t.index ["factura_id"], name: "index_linea_facturas_on_factura_id", using: :btree
  end

  create_table "lista_alumnos", force: :cascade do |t|
    t.integer  "lista_id"
    t.integer  "alumno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_lista_alumnos_on_alumno_id", using: :btree
    t.index ["lista_id"], name: "index_lista_alumnos_on_lista_id", using: :btree
  end

  create_table "listas", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movimientos", force: :cascade do |t|
    t.integer  "cuenta_id"
    t.integer  "alumno"
    t.date     "fecha"
    t.string   "descripcion"
    t.string   "extra"
    t.decimal  "debe"
    t.decimal  "haber"
    t.integer  "tipo"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "pendiente",   default: true
    t.boolean  "valido",      default: false
    t.boolean  "duda",        default: false
    t.index ["cuenta_id", "fecha"], name: "index_movimientos_on_cuenta_id_and_fecha", using: :btree
    t.index ["cuenta_id"], name: "index_movimientos_on_cuenta_id", using: :btree
    t.index ["pendiente"], name: "index_movimientos_on_pendiente", using: :btree
  end

  create_table "padre_alumnos", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "alumno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_padre_alumnos_on_alumno_id", using: :btree
    t.index ["usuario_id"], name: "index_padre_alumnos_on_usuario_id", using: :btree
  end

  create_table "pago_cuentas", force: :cascade do |t|
    t.integer  "pago_id"
    t.integer  "cuenta_id"
    t.date     "fecha"
    t.string   "descripcion"
    t.decimal  "importe"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "indice"
    t.index ["cuenta_id"], name: "index_pago_cuentas_on_cuenta_id", using: :btree
    t.index ["pago_id", "indice"], name: "index_pago_cuentas_on_pago_id_and_indice", unique: true, using: :btree
    t.index ["pago_id"], name: "index_pago_cuentas_on_pago_id", using: :btree
  end

  create_table "pagos", force: :cascade do |t|
    t.string   "nombre"
    t.binary   "data"
    t.string   "md5"
    t.boolean  "procesado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "titular_cuentas", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "cuenta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuenta_id"], name: "index_titular_cuentas_on_cuenta_id", using: :btree
    t.index ["usuario_id"], name: "index_titular_cuentas_on_usuario_id", using: :btree
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "cedula"
    t.string   "nombre"
    t.string   "apellido"
    t.string   "direccion"
    t.string   "celular"
    t.string   "alumno1"
    t.string   "alumno2"
    t.string   "alumno3"
    t.boolean  "validado"
    t.integer  "cuenta"
    t.string   "passwd"
    t.boolean  "mail"
    t.boolean  "titular"
    t.index ["cedula"], name: "index_usuarios_on_cedula", unique: true, using: :btree
    t.index ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "actividad_alumnos", "actividades"
  add_foreign_key "actividad_alumnos", "alumnos"
  add_foreign_key "actividad_listas", "actividades"
  add_foreign_key "actividad_listas", "listas"
  add_foreign_key "actividad_opciones", "actividades"
  add_foreign_key "cuenta_alumnos", "alumnos"
  add_foreign_key "cuenta_alumnos", "cuentas"
  add_foreign_key "especial_alumnos", "alumnos"
  add_foreign_key "especial_alumnos", "especiales"
  add_foreign_key "especial_cuentas", "cuentas"
  add_foreign_key "especial_cuentas", "especiales"
  add_foreign_key "especiales", "codigos"
  add_foreign_key "facturas", "cuentas"
  add_foreign_key "grado_alumnos", "alumnos"
  add_foreign_key "grado_alumnos", "grados"
  add_foreign_key "linea_facturas", "alumnos"
  add_foreign_key "linea_facturas", "facturas"
  add_foreign_key "lista_alumnos", "alumnos"
  add_foreign_key "lista_alumnos", "listas"
  add_foreign_key "movimientos", "cuentas"
  add_foreign_key "padre_alumnos", "alumnos"
  add_foreign_key "padre_alumnos", "usuarios"
  add_foreign_key "pago_cuentas", "cuentas"
  add_foreign_key "pago_cuentas", "pagos"
  add_foreign_key "titular_cuentas", "cuentas"
  add_foreign_key "titular_cuentas", "usuarios"
end
