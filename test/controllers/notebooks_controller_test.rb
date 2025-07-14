require "test_helper"

class NotebooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notebook = Notebook.create!(
      marca: "Dell",
      modelo: "XPS",
      numero_patrimonio: "PAT-CRUD",
      numero_serie: "SER-CRUD",
      identificacao_equipamento: "ID-CRUD",
      data_compra: Date.today,
      estado: :disponivel)
  end

  test "deve carregar a página de listagem (index)" do
    get notebooks_url
    assert_response :success
  end

  test "deve carregar a página de novo notebook (new)" do
    get new_notebook_url
    assert_response :success
  end

  test "deve criar um novo notebook" do
    assert_difference("Notebook.count", 1) do
      post notebooks_url, params: { notebook: { marca: "HP", modelo: "Elitebook", numero_patrimonio: "PAT-NEW", numero_serie: "SER-NEW", identificacao_equipamento: "ID-NEW", data_compra: Date.today } }
    end
    assert_redirected_to notebook_url(Notebook.last)
  end

  test "deve exibir os detalhes de um notebook (show)" do
    get notebook_url(@notebook)
    assert_response :success
  end

  test "deve carregar a página de edição (edit)" do
    get edit_notebook_url(@notebook)
    assert_response :success
  end

  test "deve atualizar um notebook" do
    patch notebook_url(@notebook), params: { notebook: { marca: "Nova Marca" } }
    assert_redirected_to notebook_url(@notebook)
    @notebook.reload
    assert_equal "Nova Marca", @notebook.marca
  end

  test "deve excluir um notebook que pode ser excluído" do
    @notebook.update(foi_emprestado: false, estado: :disponivel)

    assert_difference("Notebook.count", -1) do
      delete notebook_url(@notebook)
    end
    assert_redirected_to notebooks_url
  end

  test "não deve excluir um notebook que já foi emprestado" do
    @notebook.update(foi_emprestado: true, estado: :disponivel)

    assert_no_difference("Notebook.count") do
      delete notebook_url(@notebook)
    end
    assert_redirected_to notebook_url(@notebook)
  end
end
