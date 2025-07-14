require "test_helper"

class EmprestimosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @colaborador = Colaborador.create!(
      nome: "Usuario Teste",
      setor: "Testes")

    @notebook_disponivel = Notebook.create!(
      marca: "Dell",
      modelo: "Vostro",
      numero_patrimonio: "PAT-D",
      numero_serie: "SER-D",
      identificacao_equipamento: "ID-D",
      data_compra: Date.today,
      estado: :disponivel)

    @notebook_emprestado = Notebook.create!(
      marca: "HP",
      modelo: "Elitebook",
      numero_patrimonio: "PAT-E",
      numero_serie: "SER-E",
      identificacao_equipamento: "ID-E",
      data_compra: Date.today,
      estado: :emprestado,
      foi_emprestado: true)

    @emprestimo_ativo = Emprestimo.create!(
      notebook: @notebook_emprestado,
      colaborador: @colaborador,
      data_emprestimo: Date.today)
  end

  test "deve carregar a página de novo empréstimo" do
    get new_notebook_emprestimo_url(@notebook_disponivel)
    assert_response :success
  end

  test "deve criar um novo empréstimo" do
    assert_difference("Emprestimo.count", 1) do
      post notebook_emprestimos_url(@notebook_disponivel), params: {
        emprestimo: { colaborador_id: @colaborador.id, data_emprestimo: Date.today }
      }
    end

    assert_redirected_to notebook_url(@notebook_disponivel)

    assert @notebook_disponivel.reload.emprestado?
  end

  test "deve carregar a página de edição do empréstimo (devolução)" do
    get edit_notebook_emprestimo_url(@notebook_emprestado, @emprestimo_ativo)
    assert_response :success
  end

  test "deve atualizar um empréstimo (realizar devolução)" do
    patch notebook_emprestimo_url(@notebook_emprestado, @emprestimo_ativo), params: {
      emprestimo: { data_devolucao: Date.today, motivo_devolucao: "Finalizado" }
    }

    assert_redirected_to notebook_url(@notebook_emprestado)

    assert @notebook_emprestado.reload.disponivel?
    assert_not_nil @emprestimo_ativo.reload.data_devolucao
  end
end
