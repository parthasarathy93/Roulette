class CreateCasinos < ActiveRecord::Migration[5.0]
  def change
    create_table :casinos do |t|
      t.string :name
      t.float :balance
      t.datetime :crdate

      t.timestamps
    end
  end
end
