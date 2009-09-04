require "casino/dealer"
require "blackjack/blackjack_deck"
class BlackjackDealer < Dealer
	include HandHolder
	def initialize(deck)
		super(deck)
		@hand = BlackjackHand.new()
	end		
	def deal(player)
		player.add_card(@deck.pop())
		player.add_card(@deck.pop())
		add_card(@deck.pop())
		add_card(@deck.pop())
	end
	def hit(player)
		player.add_card(@deck.pop())
	end
	def hit_or_stay()
		if @hand.value < 17
			return hit_dealer()
		else
			return nil
		end
	end
	def hit_dealer()
		card = @deck.pop()
		add_card(card)
		return card
	end
end