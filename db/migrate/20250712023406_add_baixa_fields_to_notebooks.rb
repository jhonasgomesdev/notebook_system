class AddBaixaFieldsToNotebooks < ActiveRecord::Migration[8.0]
  def change
    add_column :notebooks, :data_baixa, :date
    add_column :notebooks, :justificativa_baixa, :text
  end
end
