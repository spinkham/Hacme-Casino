require "casino/deck"
class Dealer
	attr_accessor :deck
	def initialize(deck)
		@deck = deck
	end
end