class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :dealerid
      t.integer :casinoid
      t.datetime :gamestarttime
      t.datetime :gameendtime
      t.string :gamestatus

      t.timestamps
    end
  end
end
