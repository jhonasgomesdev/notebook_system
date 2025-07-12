class CreateEmprestimos < ActiveRecord::Migration[8.0]
  def change
    create_table :emprestimos do |t|
      t.references :notebook, null: false, foreign_key: true
      t.references :colaborador, null: false, foreign_key: true
      t.date :data_emprestimo
      t.date :data_devolucao
      t.text :motivo_devolucao

      t.timestamps
    end
  end
end
