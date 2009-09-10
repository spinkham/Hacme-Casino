require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) + '/../../../app/models/blackjack/blackjack_game'

class BlackjackGameTest < Test::Unit::TestCase
  fixtures :users
  def test_game
    @bob = users(:bob)
    game = BlackjackGame.new("Test Game", @bob)
    assert_equal "Test Game", game.name
    assert @bob.is_a?(BlackjackPlayer)
    game.bet(1000)
    assert_equal 1000, game.player.current_bet
  end
end
