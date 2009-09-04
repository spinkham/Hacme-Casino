require 'casino/hand'
require 'casino/poker_hand'
class VideoPokerHand < Hand
  attr_accessor :hold
  def rating
    PokerHand.new(@cards).hand
  end
  def clear
    super()
    @hold = [false, false, false, false, false]
  end
  
end