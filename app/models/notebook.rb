class Notebook < ApplicationRecord
  # Validando os campos obrigatórios
  validates :marca, :modelo, :numero_patrimonio, :numero_serie, :identificacao_equipamento, :data_compra, presence: true

  # Validando unicidade dos campos
  validates :numero_patrimonio, uniqueness: true
  validates :numero_serie, uniqueness: true
  validates :identificacao_equipamento, uniqueness: true

  before_update :marcar_se_foi_emrestado
  private
  def marcar_se_foi_emrestado
    if estado_changed? && estado == "emprestado"
      self.foi_emprestado = true
    end
  end
end
