require File.dirname(__FILE__)+"/video_poker_deck"
require File.dirname(__FILE__)+'/video_poker_dealer'
require File.dirname(__FILE__)+'/video_poker_player'
#require File.dirname(__FILE__)+'/../casino/card_game'
require File.dirname(__FILE__)+'/video_poker_pay_schedule'


class VideoPokerGame < Casino::CardGame
  attr_accessor :denomination
  def initialize(name, player, denomination)
    super(name)
    @dealer = VideoPokerDealer.new(VideoPokerDeck.new())
    @player = player.extend(VideoPokerPlayer)
    @denomination = denomination
    @player.vp_init
  end

  def bet(bet_amt)
     super(bet_amt)
     @state = "SELECT_HOLD_CARDS"
  end
  
  def hold_card_toggle(index)
    @player.hand.hold[index] = !@player.hand.hold[index]
  end
  
  def draw
    for i in 0..4
      if (!@player.hand.hold[i])
         dealer.redraw(player, i)
      end
    end
    return perform_results()
  end
  
  def payout
    @result = VideoPokerPaySchedule.instance.payout(@player.hand.rating, @player.current_bet)
  end
  
  def perform_results()
    @state = "GAME_OVER"
    @result = VideoPokerPaySchedule.instance.lost?(@player.hand)?"PLAYER_WON":"PLAYER_LOST"
    @change_chips = payout * @denomination
    @player.change_chips(@player.chips + @change_chips)
    @player.current_bet = 0
    return @change_chips
  end
  
end
