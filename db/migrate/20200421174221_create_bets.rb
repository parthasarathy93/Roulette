class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.integer :userid
      t.integer :gameid
      t.integer :betnumber
      t.datetime :bettime
      t.string :betstatus

      t.timestamps
    end
  end
end
