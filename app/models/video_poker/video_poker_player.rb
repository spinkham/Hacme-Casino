require 'casino/player'
require 'casino/hand_holder'
require 'video_poker_hand'
module VideoPokerPlayer 
  include HandHolder
  include Player
  def vp_init()
    @hand = VideoPokerHand.new()
    initialize_bet()
  end  
end