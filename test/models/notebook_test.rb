require "test_helper"

class NotebookTest < ActiveSupport::TestCase
  test "deve salvar um notebook com todos os campos válidos" do
    notebook = Notebook.new(
      marca: "Dell",
      modelo: "XPS 15",
      numero_patrimonio: "PAT-001",
      numero_serie: "SER-001",
      identificacao_equipamento: "NT-DEV-01",
      data_compra: Date.today,
      estado: :disponivel
    )

    assert notebook.valid?, "Notebook deveria ser válido, mas não foi. Erros: #{notebook.errors.full_messages.to_sentence}"
  end

  test "não deve salvar notebook sem marca" do
    notebook = Notebook.new(
      modelo: "XPS 15",
      numero_patrimonio: "PAT-002",
      numero_serie: "SER-002",
      identificacao_equipamento: "NT-DEV-02",
      data_compra: Date.today,
      estado: :disponivel
    )

    assert_not notebook.valid?, "Notebook foi salvo sem marca, mas não deveria."
    assert_includes notebook.errors[:marca], "can't be blank"
  end

  test "não deve salvar um notebook com número de patrimônio duplicado" do
    Notebook.create!(
      marca: "Dell",
      modelo: "XPS 15",
      numero_patrimonio: "PAT-003",
      numero_serie: "SER-003",
      identificacao_equipamento: "NT-DEV-03",
      data_compra: Date.today,
      estado: :disponivel
    )

    notebook = Notebook.new(
      marca: "HP",
      modelo: "Spectre x360",
      numero_patrimonio: "PAT-003", # Duplicado
      numero_serie: "SER-004",
      identificacao_equipamento: "NT-DEV-04",
      data_compra: Date.today,
      estado: :disponivel
    )

    assert_not notebook.valid?, "Notebook com número de patrimônio duplicado foi salvo, mas não deveria."
    assert_includes notebook.errors[:numero_patrimonio], "has already been taken"
  end
end
