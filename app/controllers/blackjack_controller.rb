class BlackjackController < GameController
  require File.dirname(__FILE__)+"/../models/blackjack/blackjack_game"
  require File.dirname(__FILE__)+"/../models/blackjack/blackjack_player" 

  def show
    session['bjgame'] = nil
    @game = game
  end
  
  def game
    if session['bjgame'].nil?
      return session['bjgame'] = BlackjackGame.new("Blackjack Game", session['user'])
    else
      return session['bjgame']
    end
  end
  
  def new_game
    @game.state = 'NEW_GAME'
    render_partial('game')     
  end
	
  def bet
    amt = params['bet'].to_i
    if is_valid_amt?(amt)
      @chips_result = game.bet(amt)
    else
      flash[:errors] = "This is not a valid amount. Do you have enough chips?"
    end
    render_partial('game')    
  end
	
  def hit_or_stay
#   if (params['card0']) 
#	 for i in 0..game.player.hand.cards.length-1
#       game.player.hand.cards[i] = Card.create_from_value(params["card"+i.to_s])
#     end
#   end
   @chips_result = game.player_hit_or_stay(params['act'])
   render_partial('game')
  end
end
