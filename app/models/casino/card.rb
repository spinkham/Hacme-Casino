class Card
	attr_accessor :suit, :rank
	@@suits = [ 's', 'd', 'h', 'c' ]
	@@ranks = [ '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A' ]
	@@valueAceLow = [ 2, 3, 4 , 5, 6, 7, 8 ,9, 10, 10, 10, 10, 11]
	@@valueAceHigh = [ 2, 3, 4 , 5, 6, 7, 8 ,9, 10, 10, 10, 10, 1]
	def initialize(suit, rank)
		@suit = suit
		@rank = rank
	end
	
	def Card.create_from_value(value)
	    suit, rank = 0,0
	    i = 0
	    @@ranks.each do |r|
          if value[0].to_s == r[0].to_s
          	rank = i
          end
          i += 1
	    end
	    i = 0
	    @@suits.each do |s|
          if value[1].to_s == s[0].to_s
          	suit = i
          end
          i += 1
	    end
	    return Card.new(suit, rank)
	end
	
	def suit
	   @@suits[@suit]
	end
	def rank
	   @@ranks[@rank]
	end
	def to_s
		return "#{rank}#{suit}"
	end
	
	def value_ace_low
		return @@valueAceLow[@rank]
	end
	
	def is_ace
		return (@rank == 12)
	end
	
end