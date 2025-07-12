class CreateColaboradores < ActiveRecord::Migration[8.0]
  def change
    create_table :colaboradores do |t|
      t.string :nome
      t.string :setor

      t.timestamps
    end
  end
end
