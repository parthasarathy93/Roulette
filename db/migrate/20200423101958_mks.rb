class Mks < ActiveRecord::Migration[5.0]
  def change
  	      change_column_default :casinos, :balance, 0
  	  	  change_column :bets, :betamount, :float, null:false


  end
end
