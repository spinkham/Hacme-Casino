require File.dirname(__FILE__) + '/../test_helper'
require 'blackjack_controller'

# Re-raise errors caught by the controller.
class BlackjackController; def rescue_action(e) raise e end; end

class BlackjackControllerTest < Test::Unit::TestCase
  fixtures :users
  def setup
    @controller = BlackjackController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session['user'] = users(:bob)
  end

  def test_bet
    @request.session['return-to'] = "/room/list"
    post :show
    assert !@controller.game.nil?
    post :bet,  "bet" => "100"
    if @controller.game.state == 'GAME_OVER'  
      assert @controller.game.player.hand.blackjack || @controller.game.dealer.hand.blackjack
    else
      assert_equal 100, @controller.game.player.current_bet  
    end
  end
end
