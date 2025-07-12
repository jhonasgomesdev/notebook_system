class Notebook < ApplicationRecord
  has_many :emprestimos
  has_many :colaboradores, through: :emprestimos

  enum :estado, { disponivel: 0, emprestado: 1, indisponivel: 2 }

  # Validando os campos obrigatórios
  validates :marca, :modelo, :numero_patrimonio, :numero_serie, :identificacao_equipamento, :data_compra, presence: true

  # Validando unicidade dos campos
  validates :numero_patrimonio, uniqueness: true
  validates :numero_serie, uniqueness: true
  validates :identificacao_equipamento, uniqueness: true

  scope :buscar, ->(termo) {
    where("identificacao_equipamento ILIKE ? OR numero_serie ILIKE ? OR numero_patrimonio ILIKE ?",
          "%#{termo}%", "%#{termo}%", "%#{termo}%")
  }

  def emprestimo_atual
    emprestimos.where(data_devolucao: nil).order(created_at: :desc).first
  end

  before_update :marcar_se_foi_emprestado
  private
  def marcar_se_foi_emprestado
    if will_save_change_to_estado? && emprestado?
      self.foi_emprestado = true
    end
  end
end
