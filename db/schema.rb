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

ActiveRecord::Schema.define(version: 2019_08_14_222157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "actividad_alumnos", id: :serial, force: :cascade do |t|
    t.integer "actividad_id"
    t.integer "alumno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "opcion"
    t.date "fecha"
    t.boolean "secretaria"
    t.boolean "mail"
    t.datetime "bajado"
    t.integer "opcion_secretaria"
    t.date "fecha_secretaria"
    t.index ["actividad_id"], name: "index_actividad_alumnos_on_actividad_id"
    t.index ["alumno_id"], name: "index_actividad_alumnos_on_alumno_id"
  end

  create_table "actividad_archivos", force: :cascade do |t|
    t.bigint "actividad_id"
    t.string "nombre"
    t.binary "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "indice"
    t.index ["actividad_id"], name: "index_actividad_archivos_on_actividad_id"
  end

  create_table "actividad_listas", id: :serial, force: :cascade do |t|
    t.integer "actividad_id"
    t.integer "lista_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actividad_id"], name: "index_actividad_listas_on_actividad_id"
    t.index ["lista_id"], name: "index_actividad_listas_on_lista_id"
  end

  create_table "actividad_opciones", id: :serial, force: :cascade do |t|
    t.integer "actividad_id"
    t.integer "valor"
    t.string "opcion"
    t.string "eleccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cuotas"
    t.decimal "importe"
    t.date "fecha"
    t.string "concepto"
    t.bigint "opcion_concepto_id"
    t.integer "indice"
    t.index ["actividad_id"], name: "index_actividad_opciones_on_actividad_id"
    t.index ["opcion_concepto_id"], name: "index_actividad_opciones_on_opcion_concepto_id"
  end

  create_table "actividades", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "descripcion"
    t.string "archivo"
    t.date "fecha"
    t.date "fechainfo"
    t.binary "data"
    t.bigint "sector_id"
    t.boolean "mail"
    t.string "creada"
    t.index ["sector_id"], name: "index_actividades_on_sector_id"
  end

  create_table "admin_usuarios", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "soporte", default: false
    t.boolean "primaria", default: false
    t.boolean "sec_mdeo", default: false
    t.boolean "sec_cc", default: false
    t.boolean "administracion", default: false
    t.boolean "inscripciones"
    t.boolean "secretaria"
    t.boolean "sue"
    t.index ["email"], name: "index_admin_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_usuarios_on_reset_password_token", unique: true
  end

  create_table "alumnos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "apellido"
    t.string "mutualista"
    t.string "emergencia"
    t.string "procede"
    t.bigint "cedula_padre_id"
    t.bigint "cedula_madre_id"
    t.integer "cedula"
    t.string "lugar_nacimiento"
    t.date "fecha_nacimiento"
    t.string "domicilio"
    t.string "celular"
    t.integer "anio_ingreso"
    t.index ["cedula_madre_id"], name: "index_alumnos_on_cedula_madre_id"
    t.index ["cedula_padre_id"], name: "index_alumnos_on_cedula_padre_id"
  end

  create_table "archivos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.binary "data"
    t.string "md5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "codigos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conceptos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configs", force: :cascade do |t|
    t.integer "anio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "anio_pases"
    t.integer "anio_inscripciones"
    t.date "fecha_facturacion"
  end

  create_table "contrato_cuotas", id: :serial, force: :cascade do |t|
    t.integer "contrato_id"
    t.date "fecha"
    t.decimal "precio"
    t.decimal "descuento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contrato_id"], name: "index_contrato_cuotas_on_contrato_id"
  end

  create_table "contratos", id: :serial, force: :cascade do |t|
    t.integer "cuenta_id"
    t.integer "anio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "validado"
    t.integer "concepto_id"
    t.integer "alumno_id"
    t.string "descripcion"
    t.string "alumno"
    t.integer "cuotas"
    t.boolean "aguinaldos"
    t.date "comienzo"
    t.decimal "importe"
    t.index ["alumno_id"], name: "index_contratos_on_alumno_id"
    t.index ["concepto_id"], name: "index_contratos_on_concepto_id"
    t.index ["cuenta_id"], name: "index_contratos_on_cuenta_id"
  end

  create_table "convenio_alumnos", id: :serial, force: :cascade do |t|
    t.integer "convenio_id"
    t.integer "alumno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_convenio_alumnos_on_alumno_id"
    t.index ["convenio_id"], name: "index_convenio_alumnos_on_convenio_id"
  end

  create_table "convenio_cuota", force: :cascade do |t|
    t.bigint "convenio_id"
    t.date "fecha"
    t.decimal "importe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cantidad"
    t.index ["convenio_id"], name: "index_convenio_cuota_on_convenio_id"
  end

  create_table "convenio_descuentos", force: :cascade do |t|
    t.bigint "convenio_id"
    t.bigint "descuento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["convenio_id"], name: "index_convenio_descuentos_on_convenio_id"
    t.index ["descuento_id"], name: "index_convenio_descuentos_on_descuento_id"
  end

  create_table "convenios", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.decimal "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ocultar_porcentaje"
    t.boolean "formulario", default: false
    t.integer "cedula"
    t.decimal "importe"
    t.decimal "porcentaje"
    t.decimal "matricula_importe"
    t.decimal "matricula_porcentaje"
  end

  create_table "cuenta_alumnos", id: :serial, force: :cascade do |t|
    t.integer "cuenta_id"
    t.integer "alumno_id"
    t.integer "numero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_cuenta_alumnos_on_alumno_id"
    t.index ["cuenta_id"], name: "index_cuenta_alumnos_on_cuenta_id"
  end

  create_table "cuentas", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.string "apellido"
    t.text "comentario"
    t.string "convenio"
    t.integer "cedula"
    t.string "direccion"
    t.string "celular"
    t.string "email"
    t.text "info"
    t.boolean "concurre"
    t.boolean "brou"
    t.string "retencion"
    t.boolean "visa"
    t.boolean "oca"
    t.index ["nombre"], name: "index_cuentas_on_nombre"
  end

  create_table "cuota_socios", force: :cascade do |t|
    t.bigint "socio_id"
    t.date "fecha"
    t.string "concepto"
    t.decimal "importe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["socio_id"], name: "index_cuota_socios_on_socio_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "descuentos", force: :cascade do |t|
    t.string "nombre"
    t.decimal "porcentaje"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deudores", force: :cascade do |t|
    t.bigint "cuenta_id"
    t.decimal "deuda360"
    t.decimal "deuda180"
    t.decimal "deuda90"
    t.decimal "deuda60"
    t.decimal "deuda30"
    t.decimal "deuda0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuenta_id"], name: "index_deudores_on_cuenta_id"
  end

  create_table "direcciones", force: :cascade do |t|
    t.bigint "usuario_id"
    t.string "direccion"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resultado"
    t.boolean "primaria", default: false
    t.boolean "secundaria", default: false
    t.boolean "costa", default: false
    t.index ["usuario_id"], name: "index_direcciones_on_usuario_id"
  end

  create_table "especial_alumnos", id: :serial, force: :cascade do |t|
    t.integer "especial_id"
    t.integer "alumno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "indice"
    t.index ["alumno_id"], name: "index_especial_alumnos_on_alumno_id"
    t.index ["especial_id", "indice"], name: "index_especial_alumnos_on_especial_id_and_indice", unique: true
    t.index ["especial_id"], name: "index_especial_alumnos_on_especial_id"
  end

  create_table "especial_cuentas", id: :serial, force: :cascade do |t|
    t.integer "especial_id"
    t.integer "cuenta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuenta_id"], name: "index_especial_cuentas_on_cuenta_id"
    t.index ["especial_id"], name: "index_especial_cuentas_on_especial_id"
  end

  create_table "especiales", id: :serial, force: :cascade do |t|
    t.date "fecha_comienzo"
    t.date "fecha_fin"
    t.string "descripcion"
    t.decimal "importe"
    t.string "nombre"
    t.binary "data"
    t.string "md5"
    t.boolean "procesado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "codigo_id"
    t.index ["codigo_id"], name: "index_especiales_on_codigo_id"
  end

  create_table "evento_usuarios", id: :serial, force: :cascade do |t|
    t.string "nombres"
    t.string "apellidos"
    t.string "telefono"
    t.string "celular"
    t.string "direccion"
    t.date "nacimiento"
    t.string "nacionalidad"
    t.string "email"
    t.string "horarios"
    t.boolean "universidad_completa"
    t.boolean "universidad_incompleta"
    t.string "trabajo"
    t.string "ultimo_trabajo"
    t.string "comentarios"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exalumnos", force: :cascade do |t|
    t.string "nombre"
    t.string "celular"
    t.string "mail"
    t.string "padre"
    t.string "celular_padre"
    t.string "mail_padre"
    t.string "madre"
    t.string "celular_madre"
    t.string "mail_madre"
    t.string "pase"
    t.string "clase"
    t.string "anio_egreso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facturas", id: :serial, force: :cascade do |t|
    t.integer "cuenta_id"
    t.date "fecha"
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "fecha_vencimiento"
    t.boolean "mail", default: false
    t.decimal "dolar"
    t.datetime "bajado"
    t.index ["cuenta_id"], name: "index_facturas_on_cuenta_id"
    t.index ["mail"], name: "index_facturas_on_mail"
  end

  create_table "formulario_inscripcion_opciones", force: :cascade do |t|
    t.bigint "formulario_id"
    t.bigint "inscripcion_opcion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formulario_id"], name: "index_formulario_inscripcion_opciones_on_formulario_id"
    t.index ["inscripcion_opcion_id"], name: "index_formulario_inscripcion_opciones_on_inscripcion_opcion_id"
  end

  create_table "formularios", force: :cascade do |t|
    t.string "nombre"
    t.integer "cedula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "proximo_grado_id"
    t.integer "anio"
    t.index ["proximo_grado_id"], name: "index_formularios_on_proximo_grado_id"
  end

  create_table "grado_alumnos", id: :serial, force: :cascade do |t|
    t.integer "grado_id"
    t.integer "alumno_id"
    t.integer "anio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_grado_alumnos_on_alumno_id"
    t.index ["grado_id"], name: "index_grado_alumnos_on_grado_id"
  end

  create_table "grados", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "anio"
    t.integer "codigo"
    t.boolean "pri_mdeo", default: false
    t.boolean "sec_mdeo", default: false
    t.boolean "sec_cc", default: false
    t.integer "proximo_grado"
  end

  create_table "inscripcion_alumnos", id: :serial, force: :cascade do |t|
    t.integer "alumno_id"
    t.integer "grado_id"
    t.integer "convenio_id"
    t.integer "hermanos"
    t.integer "cuotas"
    t.integer "mes"
    t.string "nombre1"
    t.integer "documento1"
    t.string "domicilio1"
    t.string "email1"
    t.string "celular1"
    t.string "nombre2"
    t.integer "documento2"
    t.string "domicilio2"
    t.string "email2"
    t.string "celular2"
    t.boolean "registrado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grado"
    t.integer "matricula"
    t.boolean "visa"
    t.integer "cedula"
    t.boolean "inscripto", default: false
    t.date "facturado"
    t.boolean "inhabilitado"
    t.boolean "no_inscribe"
    t.boolean "pase"
    t.index ["alumno_id"], name: "index_inscripcion_alumnos_on_alumno_id"
    t.index ["convenio_id"], name: "index_inscripcion_alumnos_on_convenio_id"
    t.index ["grado_id"], name: "index_inscripcion_alumnos_on_grado_id"
  end

  create_table "inscripcion_opcion_tipos", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inscripcion_opciones", force: :cascade do |t|
    t.string "nombre"
    t.integer "anio"
    t.bigint "inscripcion_opcion_tipo_id"
    t.date "fecha"
    t.decimal "valor"
    t.string "formato"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "general"
    t.integer "orden"
    t.index ["inscripcion_opcion_tipo_id"], name: "index_inscripcion_opciones_on_inscripcion_opcion_tipo_id"
  end

  create_table "inscripciones", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.integer "cedula"
    t.integer "proximo_grado_id"
    t.integer "convenio_id"
    t.integer "matricula"
    t.integer "hermanos"
    t.integer "cuotas"
    t.integer "mes"
    t.string "nombre1"
    t.integer "documento1"
    t.string "domicilio1"
    t.string "email1"
    t.string "celular1"
    t.string "nombre2"
    t.integer "documento2"
    t.string "domicilio2"
    t.string "email2"
    t.string "celular2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lugar_nacimiento"
    t.date "fecha_nacimiento"
    t.string "domicilio"
    t.string "celular"
    t.string "mutualista"
    t.string "emergencia"
    t.string "procede"
    t.string "nombre_padre"
    t.string "apellido_padre"
    t.string "lugar_nacimiento_padre"
    t.date "fecha_nacimiento_padre"
    t.string "email_padre"
    t.string "domicilio_padre"
    t.string "celular_padre"
    t.string "profesion_padre"
    t.string "trabajo_padre"
    t.string "telefono_trabajo_padre"
    t.boolean "titular_padre"
    t.string "nombre_madre"
    t.string "apellido_madre"
    t.string "lugar_nacimiento_madre"
    t.date "fecha_nacimiento_madre"
    t.string "email_madre"
    t.string "domicilio_madre"
    t.string "celular_madre"
    t.string "profesion_madre"
    t.string "trabajo_madre"
    t.string "telefono_trabajo_madre"
    t.boolean "titular_madre"
    t.date "fecha"
    t.string "recibida"
    t.integer "cedula_padre"
    t.integer "cedula_madre"
    t.boolean "afinidad"
    t.integer "formulario"
    t.integer "dia", default: 10
    t.integer "anio", default: 2019
    t.string "especial"
    t.integer "cuenta_id"
    t.integer "alumno_id"
    t.boolean "reinscripcion"
    t.boolean "registrado"
    t.boolean "inscripto"
    t.bigint "grado_id"
    t.boolean "inhabilitado"
    t.date "fecha_pase"
    t.string "destino_pase"
    t.integer "formulario_id"
    t.integer "adicional_id"
    t.integer "hermanos_id"
    t.integer "cuotas_id"
    t.integer "matricula_id"
    t.index ["convenio_id"], name: "index_inscripciones_on_convenio_id"
    t.index ["grado_id"], name: "index_inscripciones_on_grado_id"
    t.index ["proximo_grado_id"], name: "index_inscripciones_on_proximo_grado_id"
  end

  create_table "linea_facturas", id: :serial, force: :cascade do |t|
    t.integer "factura_id"
    t.integer "alumno_id"
    t.string "nombre_alumno"
    t.integer "indice"
    t.string "descripcion"
    t.decimal "importe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "movimiento"
    t.integer "tipo"
    t.boolean "saldo"
    t.index ["alumno_id"], name: "index_linea_facturas_on_alumno_id"
    t.index ["factura_id", "indice"], name: "index_linea_facturas_on_factura_id_and_indice", unique: true
    t.index ["factura_id"], name: "index_linea_facturas_on_factura_id"
  end

  create_table "lista_alumnos", id: :serial, force: :cascade do |t|
    t.integer "lista_id"
    t.integer "alumno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_lista_alumnos_on_alumno_id"
    t.index ["lista_id"], name: "index_lista_alumnos_on_lista_id"
  end

  create_table "listas", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "anio"
    t.bigint "sector_id"
    t.index ["sector_id"], name: "index_listas_on_sector_id"
  end

  create_table "lote_recibos", force: :cascade do |t|
    t.bigint "cuenta_id"
    t.string "nombre"
    t.date "fecha"
    t.string "suma"
    t.string "concepto"
    t.integer "hoja_nro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "nota_credito", default: false
    t.index ["cuenta_id"], name: "index_lote_recibos_on_cuenta_id"
  end

  create_table "matriculas", force: :cascade do |t|
    t.string "nombre"
    t.integer "codigo"
    t.integer "anio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movimiento2018s", force: :cascade do |t|
    t.bigint "cuenta_id"
    t.date "fecha"
    t.decimal "importe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuenta_id"], name: "index_movimiento2018s_on_cuenta_id"
  end

  create_table "movimientos", id: :serial, force: :cascade do |t|
    t.integer "cuenta_id"
    t.integer "alumno"
    t.date "fecha"
    t.string "descripcion"
    t.string "extra"
    t.decimal "debe"
    t.decimal "haber"
    t.integer "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pendiente", default: true
    t.boolean "valido", default: false
    t.boolean "duda", default: false
    t.integer "pago_cuenta_id"
    t.integer "concepto_id"
    t.integer "factura"
    t.bigint "recibo_id"
    t.decimal "saldo"
    t.integer "indice"
    t.bigint "contrato_id"
    t.bigint "actividad_alumno_id"
    t.integer "actividad_alumno_opcion"
    t.bigint "especial_id"
    t.bigint "tipo_movimiento_id"
    t.integer "rubro_debe"
    t.integer "rubro_haber"
    t.index ["actividad_alumno_id"], name: "index_movimientos_on_actividad_alumno_id"
    t.index ["concepto_id"], name: "index_movimientos_on_concepto_id"
    t.index ["contrato_id"], name: "index_movimientos_on_contrato_id"
    t.index ["cuenta_id", "fecha"], name: "index_movimientos_on_cuenta_id_and_fecha"
    t.index ["cuenta_id"], name: "index_movimientos_on_cuenta_id"
    t.index ["especial_id"], name: "index_movimientos_on_especial_id"
    t.index ["pago_cuenta_id"], name: "index_movimientos_on_pago_cuenta_id"
    t.index ["pendiente"], name: "index_movimientos_on_pendiente"
    t.index ["recibo_id"], name: "index_movimientos_on_recibo_id"
    t.index ["tipo_movimiento_id"], name: "index_movimientos_on_tipo_movimiento_id"
  end

  create_table "movs", force: :cascade do |t|
    t.bigint "placta_id"
    t.integer "movgru"
    t.integer "movcap"
    t.integer "movrub"
    t.integer "movsub"
    t.bigint "movcta"
    t.date "movfec"
    t.integer "movord"
    t.datetime "movnow"
    t.integer "movcgr"
    t.string "movcajpen"
    t.integer "movcmx"
    t.bigint "movasi"
    t.integer "movcom"
    t.string "movdes"
    t.date "movvto"
    t.integer "movcod"
    t.decimal "movdeb"
    t.decimal "movhab"
    t.decimal "movmed"
    t.decimal "movmeh"
    t.bigint "movcta1"
    t.string "movnom"
    t.string "movnompla"
    t.bigint "movcta2"
    t.string "movmov"
    t.bigint "movint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movcta", "movfec"], name: "index_movs_fec"
    t.index ["movgru", "movcap", "movrub", "movsub"], name: "index_movs_cta"
    t.index ["placta_id"], name: "index_movs_on_placta_id"
  end

  create_table "opcion_conceptos", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "padre_alumnos", id: :serial, force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "alumno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_padre_alumnos_on_alumno_id"
    t.index ["usuario_id"], name: "index_padre_alumnos_on_usuario_id"
  end

  create_table "pago_cuentas", id: :serial, force: :cascade do |t|
    t.integer "pago_id"
    t.integer "cuenta_id"
    t.date "fecha"
    t.string "descripcion"
    t.decimal "importe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "indice"
    t.index ["cuenta_id"], name: "index_pago_cuentas_on_cuenta_id"
    t.index ["pago_id", "indice"], name: "index_pago_cuentas_on_pago_id_and_indice", unique: true
    t.index ["pago_id"], name: "index_pago_cuentas_on_pago_id"
  end

  create_table "pagos", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.binary "data"
    t.string "md5"
    t.boolean "procesado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tipo_pago_id"
    t.index ["tipo_pago_id"], name: "index_pagos_on_tipo_pago_id"
  end

  create_table "pases", force: :cascade do |t|
    t.bigint "alumno_id"
    t.date "fecha"
    t.text "destino"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_pases_on_alumno_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "lugar_nacimiento"
    t.date "fecha_nacimiento"
    t.string "email"
    t.string "domicilio"
    t.string "celular"
    t.string "profesion"
    t.string "trabajo"
    t.string "telefono_trabajo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plactas", force: :cascade do |t|
    t.integer "plagru"
    t.integer "placap"
    t.integer "plarub"
    t.integer "plasub"
    t.bigint "placta"
    t.integer "moncod"
    t.string "planom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proximo_grado_alumnos", id: :serial, force: :cascade do |t|
    t.integer "alumno_id"
    t.integer "grado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_proximo_grado_alumnos_on_alumno_id"
  end

  create_table "proximo_grados", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.decimal "precio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grado"
    t.decimal "descuento"
    t.decimal "matricula"
    t.string "codigo"
    t.integer "grado_id"
    t.bigint "sector_id"
    t.integer "anio"
    t.index ["sector_id"], name: "index_proximo_grados_on_sector_id"
  end

  create_table "recargos", force: :cascade do |t|
    t.bigint "cuenta_id"
    t.boolean "recargo"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "fecha_comienzo"
    t.date "fecha_fin"
    t.index ["cuenta_id"], name: "index_recargos_on_cuenta_id"
  end

  create_table "recibos", force: :cascade do |t|
    t.string "cheque"
    t.string "banco"
    t.date "fecha_vto"
    t.decimal "importe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lote_recibo_id"
    t.index ["lote_recibo_id"], name: "index_recibos_on_lote_recibo_id"
  end

  create_table "sector_alumnos", force: :cascade do |t|
    t.bigint "alumno_id"
    t.bigint "sector_id"
    t.integer "anio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_sector_alumnos_on_alumno_id"
    t.index ["sector_id"], name: "index_sector_alumnos_on_sector_id"
  end

  create_table "sectores", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seguimientos", force: :cascade do |t|
    t.bigint "alumno_id"
    t.string "celular"
    t.boolean "no_atiende"
    t.boolean "no_inscribe"
    t.boolean "inscribe"
    t.boolean "duda"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_seguimientos_on_alumno_id"
  end

  create_table "sinregistro_cuentas", id: :serial, force: :cascade do |t|
    t.integer "cuenta_id"
    t.string "mail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuenta_id"], name: "index_sinregistro_cuentas_on_cuenta_id"
  end

  create_table "socios", force: :cascade do |t|
    t.string "nombre"
    t.integer "cedula"
    t.string "email"
    t.string "domicilio"
    t.string "celular"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "apellido"
    t.date "fecha_ingreso"
    t.string "telefono"
    t.date "fecha_egreso"
  end

  create_table "spams", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subgrado_alumnos", force: :cascade do |t|
    t.bigint "subgrado_id"
    t.bigint "alumno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "inscripto", default: false
    t.index ["alumno_id"], name: "index_subgrado_alumnos_on_alumno_id"
    t.index ["subgrado_id"], name: "index_subgrado_alumnos_on_subgrado_id"
  end

  create_table "subgrados", force: :cascade do |t|
    t.bigint "grado_id"
    t.string "nombre"
    t.decimal "precio"
    t.decimal "descuento"
    t.decimal "matricula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grado_id"], name: "index_subgrados_on_grado_id"
  end

  create_table "tarea_tipos", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tareas", id: :serial, force: :cascade do |t|
    t.string "descripcion"
    t.boolean "realizada"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tarea_tipo_id"
    t.integer "prioridad"
    t.index ["tarea_tipo_id"], name: "index_tareas_on_tarea_tipo_id"
  end

  create_table "temps", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "temp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_cuentas", id: :serial, force: :cascade do |t|
    t.integer "cuenta_id"
    t.integer "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuenta_id"], name: "index_tipo_cuentas_on_cuenta_id"
  end

  create_table "tipo_movimientos", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_pagos", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "titular_cuentas", id: :serial, force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "cuenta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuenta_id"], name: "index_titular_cuentas_on_cuenta_id"
    t.index ["usuario_id"], name: "index_titular_cuentas_on_usuario_id"
  end

  create_table "usuario_sectores", force: :cascade do |t|
    t.bigint "admin_usuario_id"
    t.bigint "sector_id"
    t.integer "indice", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_usuario_id"], name: "index_usuario_sectores_on_admin_usuario_id"
    t.index ["sector_id"], name: "index_usuario_sectores_on_sector_id"
  end

  create_table "usuarios", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cedula"
    t.string "nombre"
    t.string "apellido"
    t.string "direccion"
    t.string "celular"
    t.string "alumno1"
    t.string "alumno2"
    t.string "alumno3"
    t.boolean "validado"
    t.integer "cuenta"
    t.string "passwd"
    t.boolean "mail"
    t.boolean "titular"
    t.boolean "factura"
    t.index ["cedula"], name: "index_usuarios_on_cedula", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "actividad_alumnos", "actividades"
  add_foreign_key "actividad_alumnos", "alumnos"
  add_foreign_key "actividad_archivos", "actividades"
  add_foreign_key "actividad_listas", "actividades"
  add_foreign_key "actividad_listas", "listas"
  add_foreign_key "actividad_opciones", "actividades"
  add_foreign_key "actividad_opciones", "opcion_conceptos"
  add_foreign_key "actividades", "sectores"
  add_foreign_key "alumnos", "personas", column: "cedula_madre_id"
  add_foreign_key "alumnos", "personas", column: "cedula_padre_id"
  add_foreign_key "contrato_cuotas", "contratos"
  add_foreign_key "contratos", "alumnos"
  add_foreign_key "contratos", "conceptos"
  add_foreign_key "contratos", "cuentas"
  add_foreign_key "convenio_alumnos", "alumnos"
  add_foreign_key "convenio_alumnos", "convenios"
  add_foreign_key "convenio_cuota", "convenios"
  add_foreign_key "convenio_descuentos", "convenios"
  add_foreign_key "convenio_descuentos", "descuentos"
  add_foreign_key "cuenta_alumnos", "alumnos"
  add_foreign_key "cuenta_alumnos", "cuentas"
  add_foreign_key "cuota_socios", "socios"
  add_foreign_key "deudores", "cuentas"
  add_foreign_key "direcciones", "usuarios"
  add_foreign_key "especial_alumnos", "alumnos"
  add_foreign_key "especial_alumnos", "especiales"
  add_foreign_key "especial_cuentas", "cuentas"
  add_foreign_key "especial_cuentas", "especiales"
  add_foreign_key "especiales", "codigos"
  add_foreign_key "facturas", "cuentas"
  add_foreign_key "formulario_inscripcion_opciones", "formularios"
  add_foreign_key "formulario_inscripcion_opciones", "inscripcion_opciones"
  add_foreign_key "formularios", "proximo_grados"
  add_foreign_key "grado_alumnos", "alumnos"
  add_foreign_key "grado_alumnos", "grados"
  add_foreign_key "inscripcion_alumnos", "alumnos"
  add_foreign_key "inscripcion_alumnos", "convenios"
  add_foreign_key "inscripcion_alumnos", "grados"
  add_foreign_key "inscripcion_opciones", "inscripcion_opcion_tipos"
  add_foreign_key "inscripciones", "convenios"
  add_foreign_key "inscripciones", "grados"
  add_foreign_key "inscripciones", "proximo_grados"
  add_foreign_key "linea_facturas", "alumnos"
  add_foreign_key "linea_facturas", "facturas"
  add_foreign_key "lista_alumnos", "alumnos"
  add_foreign_key "lista_alumnos", "listas"
  add_foreign_key "listas", "sectores"
  add_foreign_key "lote_recibos", "cuentas"
  add_foreign_key "movimiento2018s", "cuentas"
  add_foreign_key "movimientos", "actividad_alumnos"
  add_foreign_key "movimientos", "conceptos"
  add_foreign_key "movimientos", "contratos"
  add_foreign_key "movimientos", "cuentas"
  add_foreign_key "movimientos", "especiales"
  add_foreign_key "movimientos", "pago_cuentas"
  add_foreign_key "movimientos", "recibos"
  add_foreign_key "movimientos", "tipo_movimientos"
  add_foreign_key "movs", "plactas"
  add_foreign_key "padre_alumnos", "alumnos"
  add_foreign_key "padre_alumnos", "usuarios"
  add_foreign_key "pago_cuentas", "cuentas"
  add_foreign_key "pago_cuentas", "pagos"
  add_foreign_key "pagos", "tipo_pagos"
  add_foreign_key "pases", "alumnos"
  add_foreign_key "proximo_grado_alumnos", "alumnos"
  add_foreign_key "proximo_grados", "sectores"
  add_foreign_key "recargos", "cuentas"
  add_foreign_key "recibos", "lote_recibos"
  add_foreign_key "sector_alumnos", "alumnos"
  add_foreign_key "sector_alumnos", "sectores"
  add_foreign_key "seguimientos", "alumnos"
  add_foreign_key "sinregistro_cuentas", "cuentas"
  add_foreign_key "subgrado_alumnos", "alumnos"
  add_foreign_key "subgrado_alumnos", "subgrados"
  add_foreign_key "subgrados", "grados"
  add_foreign_key "tareas", "tarea_tipos"
  add_foreign_key "tipo_cuentas", "cuentas"
  add_foreign_key "titular_cuentas", "cuentas"
  add_foreign_key "titular_cuentas", "usuarios"
  add_foreign_key "usuario_sectores", "admin_usuarios"
  add_foreign_key "usuario_sectores", "sectores"
end
