class Emprestimo < ApplicationRecord
  belongs_to :notebook
  belongs_to :colaborador

  validates :data_emprestimo, presence: true
end
