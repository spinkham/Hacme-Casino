require File.dirname(__FILE__) + '/../../test_helper'

class RouletteGameTest < Test::Unit::TestCase
  fixtures :users
  def test_initalize
     @bob = users(:bob)
#     game = RouletteGame.new(@bob)
#     assert game.player = @bob      
  end
  
  
#  def test_game  
#     @bob = users(:bob)
#     game = RouletteGame.new(@bob)
#     game.bet(1000, NumberBet.new(4))
#     game.bet(1000, ColorBet.new('black'))
#     game.bet(1000, CoumnBet.new(0))
#     game.bet(1000, RowBet.new(0))
#     game.bet(1000, ThirdsBet.new(0))
#     game.bet(1000, HalvesBet.new(0))
#     game.bet(1000, ParityBet.new('even'))     
#     assert game.bets.total_bets_value = 7000
#     game.roll(4)
#     assert_not_nil game.results
#  end
end