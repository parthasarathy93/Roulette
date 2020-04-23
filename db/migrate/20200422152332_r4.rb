class R4 < ActiveRecord::Migration[5.0]
  def change
  	rename_column :users,:currentcasino,:casino_id
  end
end
