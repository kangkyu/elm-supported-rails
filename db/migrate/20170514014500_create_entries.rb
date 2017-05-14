class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :phrase
      t.integer :points

      t.timestamps
    end
  end
end
