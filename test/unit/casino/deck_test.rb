require File.dirname(__FILE__) + '/../../test_helper'

class DeckTest < Test::Unit::TestCase
  def test_not_nil_cards
    deck = Deck.new()
    for i in 0..deck.length-1
      assert deck.pop()!=nil
    end
    deck.pop()
    deck.pop()
    deck.pop()
    deck.shuffle()
    for i in 0..deck.length-1
      assert deck.pop()!=nil
    end
  end
end