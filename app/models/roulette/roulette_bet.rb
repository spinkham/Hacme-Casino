class Bet
  attr_accessor :amount
  def initalize(amount)
       @amount = amount
  end
  def payout
  end
  def won?(space)
  end
end

class NumberBet < Bet
  attr_accessor :number
  def initialize(amount, number)
     super(amount)
     @number = number   
  end
  def won?(space)
    space.number == @number    
  end
  def payout
    return 36
  end
end

class ParityBet < Bet
  attr_accessor :parity
  EVEN = 'EVEN'
  ODD = 'ODD'
  def initialize(amount, parity)
     super(amount)
     @parity = parity
  end
  def won?(space)
    if (@parity == EVEN) 
      (space.number % 2) == 0
    else
      (space.number % 2) == 1    
    end
  end
  def payout
    return 2
  end
end

class ColorBet < Bet
  attr_accessor :color
  RED = 'RED'
  BLACK = 'BLACK'
  def initalize(amount, color)
    super(amount)
    @color = color
  end
  def won?(space)
    space.color = @color
  end
  def payout
    return 2
  end
end

class RowBet < Bet
  attr_accessor :index
  ROWS = [1..3, 4..6, 7..9, 10..12, 13..15, 16..18, 19..21, 22..24, 25..27, 28..30, 31..33, 34..36]
  def initialize(amount, index)
    super(amount)
    @index = index
  end
  def won?(space)
    ROWS[@index].detect(space.number).nil?
  end
  def payout
    return 12
  end
end

class ColumnBet < Bet
  attr_accessor :index
  COLUMNS = [[1,4,7,10,13,16,19,22,25,28,31,34],[2,5,8,11,14,17,20,23,26,29,32,35],[3,6,9,12,15,18,21,24,27,30,33,36]]
  def initialize(amount, index)
    super(amount)
    @index = index
  end
  def won?()
    COLUMNS[@index].detect(space.number).nil?
  end
  def payout
    return 3
  end
end

class HalvesBet < Bet
  attr_accessor :index
  HALVES = [1..18, 19..36]
  def initialize(amount, index)
    super(amount)
    @index = index
  end
  def won?()
    HALVES[@index].detect(space.number).nil?
  end
  def payout
    return 2
  end
end

class ThirdsBet < Bet
  attr_accessor :index
  THIRDS = [1..12, 13..24, 25..36]
  def initialize(amount, index)
    super(amount)
    @index = index
  end
  def won?()
    THIRDS[@index].detect(space.number).nil?
  end
  def payout
    return 3
  end
end