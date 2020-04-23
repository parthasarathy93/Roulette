class Renamecol < ActiveRecord::Migration[5.0]
  def change
  	remove_column :games, :casinoid
  	add_column :games, :betnumber, :integer
  end
end
