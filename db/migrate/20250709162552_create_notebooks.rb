class CreateNotebooks < ActiveRecord::Migration[8.0]
  def change
    create_table :notebooks do |t|
      t.string :marca
      t.string :modelo
      t.string :numero_patrimonio
      t.string :numero_serie
      t.string :identificacao_equipamento
      t.date :data_compra
      t.date :data_fabricacao
      t.text :descricao
      t.string :estado

      t.timestamps
    end
  end
end
