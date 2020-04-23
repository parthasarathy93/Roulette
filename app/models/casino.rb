class Casino < ApplicationRecord
	has_many :dealers
	has_many :games ,through: :dealers


	def active_games
	  self.games.where(gamestatus: 'start')
	end
	
end
