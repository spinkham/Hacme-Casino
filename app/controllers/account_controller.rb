class AccountController < ApplicationController
  require_dependency("user")
  layout "standard-layout"
  def login
    case request.method
      when :post
        if session['user'] = User.authenticate(params['user_login'], params['user_password'])
          session['photo'] = 'on'
          session['accessible'] = nil         
          redirect_back_or_default :controller=> "lobby", :action => "games"
        else
          flash[:errors] = "Login unsuccessful. Please try again."
          @login = params['user_login']
          redirect_back_or_default :controller=> "welcome"
      end
    end
  rescue
    flash[:errors] = "An error occured during login. Please try again."
    redirect_back_or_default :controller=> "welcome"
  end 
  
  def signup
    case request.method
      when :post
        @user = User.new(params['user'])
        @user.chips = 0
        if @user.save
          session['user'] = User.authenticate(@user.login, params['user']['password'])
          redirect_back_or_default :controller=> "lobby", :action => "games"          
        else                  
          flash[:errors] = @user.errors.full_messages
          redirect_back_or_default :controller=> "welcome", :signup => "true"
        end
      when :get
        @user = User.new
    end      
  end  
  
  def delete
    if params['id']
      @user = User.find(params['id'])
      @user.destroy
    end
    redirect_back_or_default :controller => "welcome"
  end        

  def transfer_chips
    amt = params['transfer'].to_i
    if !is_valid_amt?(amt)
      flash[:transfer_error] = "This is not an acceptable value"
      redirect_back_or_default :action => "options"
      return
    end
    donor = session['user']
    recipient = User.find_by_login(params['login'][0])
    donor.change_chips(donor.chips - amt)
    recipient.change_chips(recipient.chips + amt)
    redirect_back_or_default :action => "options"
  end
  
  def options
    @users = User.find(:all, ['login!=?', session['user'].login])
  end

  def cash_out
    amt = params['amount'].to_i
    if !is_valid_amt?(amt)
      flash[:cash_out_error] = "This is not an acceptable value"
      redirect_back_or_default :action => "options"  
      return
    end
    session['user'].chips -= amt
    puts params['account']
    if !(session['user'].login == 'andy_aces' && params['amount'].to_i >= 100000 && params['account']=="111-1111-111")
      redirect_back_or_default :action => "options"  
    end
  end
  
  def signup_form
    render_partial "signup"
  end
  
  def login_form
    render_partial "login"
  end
  
  def update_options
    session['photo'] = params['photo']
    session['accessible'] = params['accessible']
    redirect_back_or_default :action => "options"
  end
  
  def logout
    reset_session
    redirect_back_or_default :controller => "welcome"
  end
end
