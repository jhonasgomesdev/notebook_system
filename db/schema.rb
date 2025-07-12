# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_11_213749) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "colaboradors", force: :cascade do |t|
    t.string "nome"
    t.string "setor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emprestimos", force: :cascade do |t|
    t.bigint "notebook_id", null: false
    t.bigint "colaborador_id", null: false
    t.date "data_emprestimo"
    t.date "data_devolucao"
    t.text "motivo_devolucao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["colaborador_id"], name: "index_emprestimos_on_colaborador_id"
    t.index ["notebook_id"], name: "index_emprestimos_on_notebook_id"
  end

  create_table "notebooks", force: :cascade do |t|
    t.string "marca"
    t.string "modelo"
    t.string "numero_patrimonio"
    t.string "numero_serie"
    t.string "identificacao_equipamento"
    t.date "data_compra"
    t.date "data_fabricacao"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "foi_emprestado", default: false, null: false
    t.integer "estado"
  end

  add_foreign_key "emprestimos", "colaboradors"
  add_foreign_key "emprestimos", "notebooks"
end
