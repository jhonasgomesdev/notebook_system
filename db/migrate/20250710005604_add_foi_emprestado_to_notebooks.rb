class AddFoiEmprestadoToNotebooks < ActiveRecord::Migration[8.0]
  def change
    add_column :notebooks, :foi_emprestado, :boolean, default: false, null: false
  end
end
