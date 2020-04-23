class Renam2 < ActiveRecord::Migration[5.0]
  def change
  	rename_column :games,:betnumber,:thrownnumber
  end
end
