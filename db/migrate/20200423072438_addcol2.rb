class Addcol2 < ActiveRecord::Migration[5.0]
  def change
   add_column :bets,:amountwon,:float
  end
end
