require "casino/hand_holder"
module Player
	attr_accessor :current_bet
	def initialize_bet()
		@current_bet = 0
	end
end