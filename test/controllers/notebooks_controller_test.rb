require "test_helper"

class NotebooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notebooks_url
    assert_response :success
  end

  test "should get show" do
    # Cria um notebook para o teste
    notebook = Notebook.create!(
      marca: "Dell",
      modelo: "XPS",
      numero_patrimonio: "123",
      numero_serie: "ABC123",
      identificacao_equipamento: "Lab",
      data_compra: Date.today,
      data_fabricacao: Date.today,
      descricao: "Test",
      estado: "disponível",
      foi_emprestado: false
    )

    get notebook_url(notebook)
    assert_response :success
  end
end
