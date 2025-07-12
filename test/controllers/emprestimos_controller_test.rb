test "should get new" do
  notebook = Notebook.create!(
    marca: "Dell", modelo: "XPS", numero_patrimonio: "123",
    numero_serie: "ABC123", identificacao_equipamento: "Lab",
    data_compra: Date.today, data_fabricacao: Date.today,
    descricao: "Test", estado: "disponivel", foi_emprestado: false
  )

  get new_notebook_emprestimo_url(notebook)
  assert_response :success
end

test "should create emprestimo" do
  notebook = Notebook.create!(
    marca: "Dell", modelo: "XPS", numero_patrimonio: "1234",
    numero_serie: "DEF456", identificacao_equipamento: "Lab2",
    data_compra: Date.today, data_fabricacao: Date.today,
    descricao: "Test2", estado: "disponivel", foi_emprestado: false
  )

  post notebook_emprestimos_url(notebook), params: {
    emprestimo: {
      nome_usuario: "João",
      data_emprestimo: Date.today,
      data_prevista_devolucao: Date.today + 7.days
    }
  }

  assert_response :redirect
end
