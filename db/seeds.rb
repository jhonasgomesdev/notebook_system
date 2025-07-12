# db/seeds.rb

puts "Limpando o banco de dados..."
# A ordem é importante para respeitar as chaves estrangeiras
Emprestimo.destroy_all
Colaborador.destroy_all
Notebook.destroy_all

puts "Criando Colaboradores..."
20.times do
  Colaborador.create!(
    nome: Faker::Name.name,
    setor: Faker::Company.department
  )
end

puts "Criando Notebooks..."
20.times do
  # Garante que os valores únicos sejam realmente únicos
  patrimonio_unico = "PAT-#{Faker::Number.unique.number(digits: 6)}"
  serie_unica = "SER-#{Faker::Alphanumeric.unique.alphanumeric(number: 10).upcase}"

  Notebook.create!(
    marca: Faker::Device.manufacturer,
    modelo: Faker::Device.model_name,
    numero_patrimonio: patrimonio_unico,
    numero_serie: serie_unica,
    identificacao_equipamento: "NT-#{Faker::Number.number(digits: 4)}",
    data_compra: Faker::Date.between(from: 5.years.ago, to: Date.today),
    data_fabricacao: Faker::Date.backward(days: 1825),
    descricao: "Equipamento cadastrado via seed.",
    estado: "disponivel" # Todos começam como disponíveis
  )
end

puts "Criando Empréstimos..."
# Vamos pegar 15 dos notebooks disponíveis para emprestar
notebooks_para_emprestar = Notebook.disponivel.limit(15).to_a
colaboradores = Colaborador.all.to_a

notebooks_para_emprestar.each do |notebook|
  colaborador_aleatorio = colaboradores.sample # Pega um colaborador aleatório

  # Cria o registro de empréstimo
  emprestimo = Emprestimo.create!(
    notebook: notebook,
    colaborador: colaborador_aleatorio,
    data_emprestimo: Faker::Date.between(from: 1.month.ago, to: Date.today)
  )

  # Atualiza o estado do notebook
  notebook.emprestado!
end

puts "Banco de dados populado com sucesso!"
puts "------------------------------------"
puts "Resumo:"
puts "#{Colaborador.count} colaboradores criados."
puts "#{Notebook.count} notebooks criados."
puts "#{Emprestimo.count} empréstimos ativos."
puts "#{Notebook.disponivel.count} notebooks disponíveis."
