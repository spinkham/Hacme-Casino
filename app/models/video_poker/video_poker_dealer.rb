require 'casino/dealer'
class VideoPokerDealer < Dealer
  def deal(player)
    for i in 0..4
      player.hand.cards[i] = @deck.pop      
    end
  end
  def redraw(player, index)
    player.hand.cards[index] = @deck.pop
  end
end
