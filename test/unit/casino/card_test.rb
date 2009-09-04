require File.dirname(__FILE__) + '/../../test_helper'

class CardTest < Test::Unit::TestCase
  def test_initialize
    card1 = Card.new(0,1)
    card2 = Card.create_from_value('3s')
    assert_equal card1.to_s, card2.to_s
    card2 = Card.create_from_value('Ad')
    assert_equal 'Ad', card2.to_s
  end
end