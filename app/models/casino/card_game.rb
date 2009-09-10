class Casino::CardGame
  attr_accessor :name, :player, :dealer, :state, :result
  def initialize(name)
    @name = name
    @state = 'NEW_GAME'
    @result = nil
  end
  
  def prepare_game
    @player.hand.clear()
    @dealer.deck.shuffle()
    @player.initialize_bet()
    @state = 'NEW_GAME'
  end
  
  def bet(bet_amt)
    prepare_game
    @player.current_bet = bet_amt
    @dealer.deal(@player)    
  end 
end
