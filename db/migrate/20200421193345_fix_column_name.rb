class FixColumnName < ActiveRecord::Migration[5.0]
  def change
  	    rename_column :dealers, :casinoid, :casino_id

  end
end
