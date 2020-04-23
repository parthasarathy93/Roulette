class Ultimate < ActiveRecord::Migration[5.0]
  def change
  	  change_column :games, :gamestarttime, :datetime, null:false
  	  change_column_default :bets, :betstatus,'active'
  	  remove_column :casinos, :crdate
  	  remove_column :bets,:bettime
  	    	  remove_column :users, :crdate
  	  remove_column :users, :moddate

  	  change_column_default :games, :gamestatus,'start'

  end
end
