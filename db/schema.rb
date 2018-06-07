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

ActiveRecord::Schema.define(version: 20180605122020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actividad_alumnos", force: :cascade do |t|
    t.integer  "actividad_id"
    t.integer  "alumno_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "opcion"
    t.index ["actividad_id"], name: "index_actividad_alumnos_on_actividad_id", using: :btree
    t.index ["alumno_id"], name: "index_actividad_alumnos_on_alumno_id", using: :btree
  end

  create_table "actividad_opciones", force: :cascade do |t|
    t.integer  "actividad_id"
    t.integer  "valor"
    t.string   "opcion"
    t.string   "eleccion"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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
  end

  create_table "alumnos", force: :cascade do |t|
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
  add_foreign_key "actividad_opciones", "actividades"
  add_foreign_key "cuenta_alumnos", "alumnos"
  add_foreign_key "cuenta_alumnos", "cuentas"
  add_foreign_key "grado_alumnos", "alumnos"
  add_foreign_key "grado_alumnos", "grados"
  add_foreign_key "movimientos", "cuentas"
  add_foreign_key "padre_alumnos", "alumnos"
  add_foreign_key "padre_alumnos", "usuarios"
  add_foreign_key "titular_cuentas", "cuentas"
  add_foreign_key "titular_cuentas", "usuarios"
end
