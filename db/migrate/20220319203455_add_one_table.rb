class AddOneTable < ActiveRecord::Migration[6.1]
  create_table :users do |t|
    t.string :name, null: false
    t.string :email, null: false
    t.integer :age
    t.jsonb :dataset

    t.timestamps
  end
end
