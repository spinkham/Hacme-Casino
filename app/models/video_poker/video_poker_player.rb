require File.dirname(__FILE__)+'/../casino/player'
require File.dirname(__FILE__)+'/../casino/hand_holder'
require File.dirname(__FILE__)+'/video_poker_hand'
module VideoPokerPlayer 
  include HandHolder
  include Player
  def vp_init()
    @hand = VideoPokerHand.new()
    initialize_bet()
  end  
end
