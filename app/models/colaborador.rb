class Colaborador < ApplicationRecord
  has_many :emprestimos
  has_many :notebooks
end
