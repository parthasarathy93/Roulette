class Mks1 < ActiveRecord::Migration[5.0]
  def change

  	  	      change_column_default :casinos, :balance, '0'

  end
end
