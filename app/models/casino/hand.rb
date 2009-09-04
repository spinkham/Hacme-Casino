require "casino/card"
class Hand
	attr_accessor :cards
	def initialize()
      clear()
	end
	def add_card(card)
	  @cards.push(card)
	end
	def to_s()
	  return @cards.to_s()
	end	
	def clear()
	  @cards = Array.new()
	end	
	def length()
	  @cards.length
	end
end