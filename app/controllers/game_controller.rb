class GameController < ApplicationController
  layout "standard-layout"
  before_filter :login_required, :require_game
end
