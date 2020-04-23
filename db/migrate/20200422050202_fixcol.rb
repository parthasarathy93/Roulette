class Fixcol < ActiveRecord::Migration[5.0]
  def change
  	  	    rename_column :games, :dealerid, :dealer_id

  end
end
