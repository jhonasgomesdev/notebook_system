require "test_helper"

class EmprestimoTest < ActiveSupport::TestCase
  setup do
    @notebook = Notebook.create!(
      marca: "Apple",
      modelo: "MacBook Pro",
      numero_patrimonio: "PAT-001",
      numero_serie: "SER-001",
      identificacao_equipamento: "NT-DEV-01",
      data_compra: Date.today,
      estado: :disponivel
    )
    @colaborador = Colaborador.create!(
      nome: "Ana Costa",
      setor: "TI"
    )
  end

  test "deve salvar um empréstimo com todos os campos válidos" do
    emprestimo = Emprestimo.new(
      notebook: @notebook,
      colaborador: @colaborador,
      data_emprestimo: Date.today
    )

    assert emprestimo.valid?, "Empréstimo deveria ser válido, mas não foi. Erros: #{emprestimo.errors.full_messages.to_sentence}"
  end

  test "não deve salvar empréstimo sem um notebook associado" do
    emprestimo = Emprestimo.new(
      colaborador: @colaborador,
      data_emprestimo: Date.today
    )

    assert_not emprestimo.valid?, "Empréstimo foi salvo sem um notebook, mas não deveria."
    assert_includes emprestimo.errors[:notebook], "must exist"
  end

  test "não deve salvar empréstimo sem um colaborador associado" do
    emprestimo = Emprestimo.new(
      notebook: @notebook,
      data_emprestimo: Date.today
    )

    assert_not emprestimo.valid?, "Empréstimo foi salvo sem um colaborador, mas não deveria."
    assert_includes emprestimo.errors[:colaborador], "must exist"
  end

  test "não deve salvar empréstimo sem data de empréstimo" do
    emprestimo = Emprestimo.new(
      notebook: @notebook,
      colaborador: @colaborador
    )

    assert_not emprestimo.valid?, "Empréstimo foi salvo sem data de empréstimo, mas não deveria."
    assert_includes emprestimo.errors[:data_emprestimo], "can't be blank"
  end
end
