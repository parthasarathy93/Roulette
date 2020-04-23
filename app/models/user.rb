class User < ApplicationRecord

	has_many :bets

	has_many :games, through: :bets

    def casino
      Casino.find(casino_id)
    end


end
	