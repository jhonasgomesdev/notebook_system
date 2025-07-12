class MigrateEstadoDeStringParaInteger < ActiveRecord::Migration[8.0]
  # Declara o model Notebook para uso na migration
  class Notebook < ApplicationRecord; end

  def up
    add_column :notebooks, :estado_temp, :integer

    estados = {
      "disponível" => 0,
      "emprestado" => 1,
      "indisponível" => 2
    }

    Notebook.reset_column_information
    Notebook.find_each do |notebook|
      valor = estados[notebook.estado]
      notebook.update_column(:estado_temp, valor) if valor.present?
    end

    remove_column :notebooks, :estado
    rename_column :notebooks, :estado_temp, :estado
  end

  def down
    add_column :notebooks, :estado_temp, :string

    estados = {
      0 => "disponível",
      1 => "emprestado",
      2 => "indisponível"
    }

    Notebook.reset_column_information
    Notebook.find_each do |notebook|
      valor = estados[notebook.estado]
      notebook.update_column(:estado_temp, valor) if valor.present?
    end

    remove_column :notebooks, :estado
    rename_column :notebooks, :estado_temp, :estado
  end
end