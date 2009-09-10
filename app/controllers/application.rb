# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'login_system'

class ApplicationController < ActionController::Base
    include LoginSystem
    require_dependency("user")
    def require_game
      @game = game
    end
    def is_valid_amt?(amt)
     if (session['user'].nil?)
       return false
     elsif (amt <= 0)
       return false
     elsif (amt > session['user'].chips)
       return false
     end
     return true
  end  
    
end
