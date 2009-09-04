require File.dirname(__FILE__) + '/../../test_helper'

class VideoPokerPayScheduleTest < Test::Unit::TestCase
  
  def test_payout
    assert_equal 1000, VideoPokerPaySchedule.instance.payout("Royal Flush", 4)
  end
end