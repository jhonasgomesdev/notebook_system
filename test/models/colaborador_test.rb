require "test_helper"

class ColaboradorTest < ActiveSupport::TestCase
  test "deve salvar um colaborador com todos os campos vállidos" do
    colaborador = Colaborador.new(
      nome: "Maria Oliveira",
      setor: "Recursos Humanos"
    )

    assert colaborador.valid?, "Colaborador deveria ser válido, mas não foi. Erros: #{colaborador.errors.full_messages.to_sentence}"
  end

  test "não deve salvar colaborador sem nome" do
    colaborador = Colaborador.new(
      setor: "Financeiro"
    )

    assert_not colaborador.valid?, "Colaborador foi salvo sem nome, mas não deveria."
    assert_includes colaborador.errors[:nome], "can't be blank"
  end

  test "não deve salvar colaborador sem setor" do
    colaborador = Colaborador.new(
      nome: "Carlos Souza"
    )

    assert_not colaborador.valid?, "Colaborador foi salvo sem setor, mas não deveria."
    assert_includes colaborador.errors[:setor], "can't be blank"
  end
end
