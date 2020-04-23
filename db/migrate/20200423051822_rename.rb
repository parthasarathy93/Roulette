class Rename < ActiveRecord::Migration[5.0]
  def change
  	rename_column :bets, :userid, :user_id
  	rename_column :bets, :gameid, :game_id
  end
end
