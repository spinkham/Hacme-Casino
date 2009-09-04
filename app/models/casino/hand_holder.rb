require "casino/hand"
module HandHolder
	attr_accessor :hand
	def add_card(card)		
		@hand.add_card(card)
	end
	def clear_hand()
		@hand = @hand.class.new()		
	end
end