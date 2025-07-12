class Emprestimo < ApplicationRecord
  belongs_to :notebook
  belongs_to :colaborador
end
