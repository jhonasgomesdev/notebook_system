class Colaborador < ApplicationRecord
  has_many :emprestimos
  has_many :notebooks, through: :emprestimos

  validates :nome, presence: true
  validates :setor, presence: true

  def emprestimos_ativos
    emprestimos.where(data_devolucao: nil)
  end
end
