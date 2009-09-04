require "singleton"
class VideoPokerPaySchedule
  include Singleton
  @@schedule = {
      "Royal Flush" => [250, 500, 750, 1000, 4000],
      "Straight Flush" => 	[50, 100, 150, 200, 250],
      "Four of a Kind" => [25, 50, 75, 100, 125],
      "Full House" 	=> [9, 18, 27, 36, 45],
      "Flush"  => [6, 12, 18, 24, 30],
      "Straight" =>  [4, 8, 12, 16, 20],
      "Three of a Kind" => [3, 6, 9, 12, 15],
      "Two Pair" => [2, 4, 6, 8, 10],
      "Jacks or Better" => [1, 2, 3, 4, 5]
  }

  def lost?(hand)
    hand == "High Card" || hand == "Pair"
  end

  def payout(hand, credits)
    return -1 * credits unless !lost?(hand)
    @@schedule[hand][credits - 1]
  end
  
  def schedule
    return @@schedule
  end
end