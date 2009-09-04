require File.dirname(__FILE__) + '/../../test_helper'
require 'casino/card'
class PokerHandTest < Test::Unit::TestCase
  def test_poker_hand
     rf_cards = ['As', 'Ks', 'Qs', 'Js', 'Ts'].collect { |card| Card.create_from_value(card)}
     assert_equal 'AsKsQsJsTs', rf_cards.to_s
     rf_cards.each do |card|
        assert_not_nil card.suit
        assert_not_nil card.rank
     end
     poker_hand = PokerHand.new(rf_cards)
     assert poker_hand.royal_flush?
     assert_equal "Royal Flush", poker_hand.hand 
     
     fh_cards = ['As', 'Ad', 'Ac', 'Ks', 'Kd'].collect { |card| Card.create_from_value(card)}
     fh_cards.each do |card|
        assert_not_nil card.suit
        assert_not_nil card.rank
     end
     poker_hand = PokerHand.new(fh_cards)
     assert poker_hand.full_house?
     assert_equal "Full House", poker_hand.hand 

  end
end