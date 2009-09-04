require 'video_poker/video_poker_pay_schedule'
require 'casino/poker_hand'
module VideoPokerHelper
  def render_video_poker_pay_schedule()
    @pay_schedule = VideoPokerPaySchedule.instance.schedule()
    @hands = PokerHand.new(nil).hand_order
    @table_string = "<table><th>Hand</th><th>1 Credit</th><th>2 Credit</th><th>3 Credit</th><th>4 Credit</th><th>5 Credit</th>"
    @hands.each do |key|
      if (!@pay_schedule[key].nil?)
        @table_string += "<tr>" 
        @table_string += "<td class='hand'>#{key}</td>"        
        @pay_schedule[key].each do |value|
          @table_string += "<td>#{value}</td>"
        end
      end
      @table_string += "</tr>" 
    end
    @table_string += "</table>"
    return @table_string
  end
end
