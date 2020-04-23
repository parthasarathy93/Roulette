class CreateGameHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :game_histories do |t|
      t.integer :game_id
      t.integer :user_id
      t.datetime :gametime

      t.timestamps
    end
  end
end
