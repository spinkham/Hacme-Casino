require File.dirname(__FILE__) + '/../../test_helper'
require 'casino/card'
require File.dirname(__FILE__) + '/../../../app/models/video_poker/video_poker_game'
class VideoPokerGameTest < Test::Unit::TestCase
  fixtures :users
  def test_game
    @bob = users(:bob)
    game = VideoPokerGame.new('Video Poker - Five Card Draw', @bob, 100)
    assert game.state == 'NEW_GAME'
    assert_equal game.player, @bob
    assert_equal 0, game.player.current_bet
    
    game.bet(3)
    assert_equal 3, game.player.current_bet
    assert_equal 5, game.player.hand.cards.length
    
    game.hold_card_toggle(2)
    assert game.player.hand.hold[2] = true    
    
    game.draw
    assert  (-300..75000) === game.payout

    game.bet(3)
    fh_cards = make_cards(['As', 'Ad', 'Ac', 'Ks', 'Kd'])
    game.player.hand.cards = fh_cards
    assert_equal 3, game.player.current_bet
    assert_equal 27, game.payout
    
    bad_cards = make_cards(['Ts', '9s', '3s', '2s', 'Ah'])
    game.player.hand.cards = bad_cards
    assert_equal -3, game.payout
    
    pair_of_tens = make_cards(['Ts', 'Td', '4c', '3c', '2c'])
    game.player.hand.cards = pair_of_tens
    assert_equal -3, game.payout
   
    pair_of_jacks = make_cards(['Js', 'Jd', '4c', '3c', '2c'])
    game.player.hand.cards = pair_of_jacks
    assert_equal 3, game.payout
    
    royal_flush = make_cards(['Ts', 'Js', 'Qs', 'Ks', 'As'])
    game.player.hand.cards = royal_flush
    assert_equal 750, game.payout

    flush = make_cards(['Ts', '8s', 'Qs', '3s', 'As'])
    game.player.hand.cards = flush
    assert_equal 18, game.payout

    
  end

  def make_cards(list)
    list.collect { |card| Card.create_from_value(card)}
  end
end
