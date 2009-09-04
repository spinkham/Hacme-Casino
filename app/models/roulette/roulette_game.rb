class RouletteGame
  attr_accessor :player, :bets, :wheel, :results

  def initialize(user)
    @player = user.extend(RoulettePlayer)    
  end
  
  def bet
    @bets.add
  end

  def roll

  end
end