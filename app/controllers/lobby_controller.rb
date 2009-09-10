class LobbyController < ApplicationController
  layout "standard-layout"
  before_filter :login_required
  def games

  end

  def not_yet
    render :text => "This game is not available yet. Please check back soon!"
  end

end
