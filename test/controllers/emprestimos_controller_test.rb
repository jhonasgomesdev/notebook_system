require "test_helper"

class EmprestimosControllerTest < ActionDispatch::IntegrationTest
  # O bloco setup roda uma vez antes de cada teste nesta classe.
  setup do
    # Criamos um notebook e o deixamos disponível como uma variável de instância (@notebook)
    # para todos os testes.
    @notebook = Notebook.create!(
      marca: "Dell",
      modelo: "XPS",
      numero_patrimonio: "PAT-12345",
      numero_serie: "SER-XYZ",
      identificacao_equipamento: "TI-DEV-01",
      data_compra: Date.today,
      estado: "disponivel" # Corrigido para usar o valor com acento
    )
  end

  test "should get new" do
    # Usamos o @notebook criado no setup
    get new_notebook_emprestimo_url(@notebook)
    assert_response :success
  end

  test "should create emprestimo" do
    # Verifica que um novo Emprestimo será criado após a execução do bloco
    assert_difference("Emprestimo.count", 1) do
      post notebook_emprestimos_url(@notebook), params: {
        emprestimo: {
          # Corrigido: Usando os nomes de parâmetros corretos que o controller espera
          nome_colaborador: "João da Silva",
          setor: "Desenvolvimento",
          data_emprestimo: Date.today
        }
      }
    end

    # Após a criação, verifica se fomos redirecionados para a página do notebook
    assert_redirected_to notebook_url(@notebook)

    # Recarrega o estado do notebook do banco de dados para pegar a atualização
    @notebook.reload

    # Verifica se o estado do notebook foi realmente alterado para "emprestado"
    assert @notebook.emprestado?, "O estado do notebook não foi alterado para 'emprestado'"
  end
end
