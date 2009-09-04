def RouletteSpace
  attr_accessor :color, :number
  def initialize(color, number)
    @color = color
    @number = number
  end
end

def RouletteWheel
  attr_accessor :spaces
  def initialize
    spaces = Array.new(38)
    spaces[0] = RouletteSpace.new(0, 'GREEN')
    spaces[1] = RouletteSpace.new(-1, 'GREEN') # I think we will represent these as integers
    @color = 'BLACK'    
    for i in 1..36
      spaces[i+1] = RouletteSpace.new(i, @color)
      if (@color == 'BLACK')
        @color = 'RED'
      else
        @color = 'BLACK'
      end
    end
  end
  
  def spin
    return spaces[rand(38).to_i]
  end
  
end