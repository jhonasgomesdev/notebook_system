require "test_helper"

class EmprestimosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @colaborador = Colaborador.create!(
      nome: "João da Silva",
      setor: "Desenvolvimento"
    )

    @notebook = Notebook.create!(
      marca: "Dell",
      modelo: "XPS",
      numero_patrimonio: "PAT-12345",
      numero_serie: "SER-XYZ",
      identificacao_equipamento: "TI-DEV-01",
      data_compra: Date.today,
      estado: :disponivel
    )
  end

  test "should get new" do
    get new_notebook_emprestimo_url(@notebook)
    assert_response :success
  end

  test "should create emprestimo" do
    assert_difference("Emprestimo.count", 1) do
      post notebook_emprestimos_url(@notebook), params: {
        emprestimo: {
          colaborador_id: @colaborador.id,
          data_emprestimo: Date.today
        }
      }
    end

    assert_redirected_to notebook_url(@notebook)
    @notebook.reload
    assert @notebook.emprestado?, "O estado do notebook não foi alterado para 'emprestado'"
  end
end
