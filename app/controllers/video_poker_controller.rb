require File.dirname(__FILE__)+"/../models/video_poker/video_poker_game"
class VideoPokerController < GameController
  def show
    session['vpgame'] = nil
    @game = game
  end
  def game
    if session['vpgame'].nil?
      return session['vpgame'] = VideoPokerGame.new("Video Poker Game", session['user'], 100)
    else
      return session['vpgame']
    end
  end
  
  def new_game
    @game.state = 'NEW_GAME'
    render_partial('game')     
  end
  
  def bet
    denomination = params['denomination'].to_i
    bet = params['bet'].to_i
    if (is_valid_amt?(bet * denomination))
	  @game.denomination = denomination
	  @game.bet(bet)	  
	else 
	  flash[:errors] = "This is not a valid amount. Do you have enough chips?"
    end
    render_partial('game')    
  end

  def test_deuces_wild
    #  NOTE: This is a stub for future development...
    @game.set_deuces_wild
  end
  
  def draw
    for @index in 0..4
      if params['hold_' + @index.to_s] == 'true'
        @game.hold_card_toggle(@index)
      end
    end
    @chips_result = @game.draw
    render_partial('game')
  end
      
end
