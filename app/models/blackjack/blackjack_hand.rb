require "casino/hand"
require "casino/card"
class BlackjackHand < Hand
  def value
	max_value = 0
	high_aces = 0
	cards.each do |card|
      max_value += card.value_ace_low
      if (card.is_ace()) 
        high_aces += 1
      end
    end
    while (max_value > 21 && high_aces > 0)
      max_value -= 10
      high_aces -= 1		
    end
    return max_value		
  end
  def busted()
    return (self.value > 21)
  end
  def blackjack
    return ((self.value == 21) && (cards.length == 2))
  end
end