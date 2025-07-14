require "test_helper"

class ColaboradoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @colaborador = Colaborador.create!(nome: "Carlos Teste", setor: "Engenharia")
  end

  test "deve carregar a página de listagem (index)" do
    get colaboradores_url
    assert_response :success
  end

  test "deve carregar a página de novo colaborador (new)" do
    get new_colaborador_url
    assert_response :success
  end

  test "deve criar um novo colaborador" do
    assert_difference("Colaborador.count", 1) do
      post colaboradores_url, params: { colaborador: { nome: "Maria Nova", setor: "Marketing" } }
    end
    assert_redirected_to colaborador_url(Colaborador.last)
  end

  test "deve exibir os detalhes de um colaborador (show)" do
    get colaborador_url(@colaborador)
    assert_response :success
  end

  test "deve carregar a página de edição (edit)" do
    get edit_colaborador_url(@colaborador)
    assert_response :success
  end

  test "deve atualizar um colaborador" do
    patch colaborador_url(@colaborador), params: { colaborador: { setor: "Produto" } }
    assert_redirected_to colaborador_url(@colaborador)

    @colaborador.reload
    assert_equal "Produto", @colaborador.setor
  end

  test "deve excluir um colaborador" do
    assert_difference("Colaborador.count", -1) do
      delete colaborador_url(@colaborador)
    end
    assert_redirected_to colaboradores_url
  end
end
