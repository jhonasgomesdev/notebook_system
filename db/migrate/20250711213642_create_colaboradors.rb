class CreateColaboradors < ActiveRecord::Migration[8.0]
  def change
    create_table :colaboradors do |t|
      t.string :nome
      t.string :setor

      t.timestamps
    end
  end
end
