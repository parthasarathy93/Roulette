class Dealer < ApplicationRecord
	has_many :games
	belongs_to :casino
	
end
