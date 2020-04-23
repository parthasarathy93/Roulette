class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.float :balance
      t.integer :currentcasino
      t.datetime :crdate
      t.datetime :moddate

      t.timestamps
    end
  end
end
