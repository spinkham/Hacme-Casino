require "casino/player"
module BlackjackPlayer 
  include HandHolder
  include Player
  def bj_init()
    @hand = BlackjackHand.new()
    initialize_bet()
  end
  def hand_value()
  	@hand.value
  end
end