module GameHelper
  def card_img(card)
    if (card != nil)
      return "<img src='/images/cards/#{card}.bmp'/>"
    else
      return "<img src='/images/cards/empty.bmp'/>"
    end
  end
  
  def player_card_img(card)
    if (card != nil)
      return "<img class='player' src='/images/cards/#{card}.bmp'/>"
    else
      return "<img src='/images/cards/empty.bmp'/>"
    end
  end
  
  def selectable_card_img(card)
    return "/images/cards/#{card}.bmp"
  end

end
