require File.dirname(__FILE__)+"/blackjack_deck"
require File.dirname(__FILE__)+"/blackjack_player"
require File.dirname(__FILE__)+"/blackjack_dealer"
require File.dirname(__FILE__)+"/blackjack_hand"

class BlackjackGame < Casino::CardGame
  def initialize(name, player)
    super(name)
    @dealer = BlackjackDealer.new(BlackjackDeck.new())
  	@player = player.extend(BlackjackPlayer)
    @player.bj_init()
  end
  
  def prepare_game
      super()
      @dealer.hand.clear()
  end
  
  def bet(bet_amt)
    super(bet_amt)
    check_for_blackjack()
    return perform_results()
  end


  def check_for_blackjack
    if @player.hand.blackjack
      @state = 'GAME_OVER'
      @result = 'BLACKJACK'
    elsif @dealer.hand.blackjack
      @state = 'GAME_OVER'
      @result = 'PLAYER_LOST'
    else
      @state = 'PLAYER_H_OR_S'
    end
  end
  
  def player_hit_or_stay(action)
    if (action == 'H')
      @dealer.hit(@player)
	  if (@player.hand.busted())
	     @result = 'PLAYER_LOST'
	     @state = 'GAME_OVER'
      end
    elsif (action == 'S')
      dealer_hit_or_stay
    elsif (action == 'D')
      @state = double_down
    elsif (action == 'X')
      @state = split
    else
      puts "Bad action: #{action}"
    end
    return perform_results()
  end

  def double_down
    @player.current_bet  *= 2
    @dealer.hit(@player)
    dealer_hit_or_stay
  end
	
  def dealer_hit_or_stay
    while (@dealer.hand.value < 17)
      dealer.hit(dealer)
    end
    if (dealer.hand.busted() || (player.hand.value > dealer.hand.value))
      @state = 'GAME_OVER'
      @result = 'PLAYER_WON'
    elsif (player.hand.value == dealer.hand.value)
	  @state = 'GAME_OVER'
      @result = 'PUSH'
    else
      @state = 'GAME_OVER'
      @result = 'PLAYER_LOST'
    end
  end
  
  def perform_results()
    if (@state != 'GAME_OVER') then return end 
    chips = player.chips
    chips_result = 0
    if (@result == 'PLAYER_WON')
      chips_result = player.current_bet
    elsif (@result == 'PLAYER_LOST' || @result == 'DEALER_BLACKJACK')
      chips_result =  -1 * player.current_bet
    elsif (@result == 'BLACKJACK')
      chips_result = player.current_bet * 1.15
    end
    player.change_chips(chips + chips_result)
    return chips_result
  end
  
end
