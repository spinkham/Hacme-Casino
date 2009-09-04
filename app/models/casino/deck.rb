require "casino/card"
class Deck
  attr_accessor :cards
  def initialize()
  	fill()
  end
	
  def fill()
  	@cards = Array.new(52)
  	i=0
  	for s in 0..3
 	  for r in 0..12				
        @cards[i] = Card.new(s,r)
        i = i + 1
      end
	end	
  end
  
  def shuffle()
    fill()
    for i in 0..51
      swap = rand(52).to_i
      @cards[i], @cards[swap] = @cards[swap], @cards[i]
    end
    return self
  end
  def pop()
    card = @cards.pop
    return card
  end
  def to_s
    return cards.to_s
  end
  def length
    return @cards.length
  end
	
end
