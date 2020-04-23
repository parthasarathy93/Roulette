class Addcol < ActiveRecord::Migration[5.0]
  def change
  	add_column :bets,:betamount,:float
  end
end
