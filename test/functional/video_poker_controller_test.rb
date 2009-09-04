require File.dirname(__FILE__) + '/../test_helper'
require 'video_poker_controller'
require 'video_poker/video_poker_game'
require 'video_poker/video_poker_player'
require 'video_poker/video_poker_hand'
require 'video_poker_helper'
require 'blackjack_controller'
require 'blackjack/blackjack_game'
require 'blackjack/blackjack_player'
require 'blackjack/blackjack_hand'
# Re-raise errors caught by the controller.
class VideoPokerController; def rescue_action(e) raise e end; end

class VideoPokerControllerTest < Test::Unit::TestCase
  fixtures :users
  def setup
    @controller = VideoPokerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session['user'] = users(:bob)
  end
  

  def test_video_poker
     post :show
     assert @controller.game.is_a?(VideoPokerGame)
     post :bet, :bet => 5, :denomination => 100
     assert_equal 5, @controller.game.player.current_bet
  end
  
  def test_video_poker_after_blackjack
    @backup_controller = @controller
    @controller = BlackjackController.new()
    post :show
    assert @controller.game.is_a?(BlackjackGame)
    assert @controller.game.player.is_a?(BlackjackPlayer)
    post :bet, :bet => 5
    assert @controller.game.player.hand.is_a?(BlackjackHand)
    
    @controller = @backup_controller 
    post :show
    assert @controller.game.is_a?(VideoPokerGame)
    assert @controller.game.player.is_a?(VideoPokerPlayer)
    post :bet, :bet => 5, :denomination => 100
    assert @controller.game.player.hand.is_a?(VideoPokerHand)   
  end
  def test_video_poker_helper
  end
  
end
