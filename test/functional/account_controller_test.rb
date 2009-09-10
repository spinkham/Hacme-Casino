require File.dirname(__FILE__) + '/../test_helper'
require 'account_controller'

# Raise errors beyond the default web-based presentation
class AccountController; def rescue_action(e) raise e end; end

class AccountControllerTest < Test::Unit::TestCase
  self.use_instantiated_fixtures  = true  
  fixtures :users
  
  def setup
    @controller = AccountController.new
    @request, @response = ActionController::TestRequest.new, ActionController::TestResponse.new
    @request.host = "localhost"
  end
  
  def test_auth_bob
  post :login, "user_login" => "bob", "user_password" => "test"
    assert(@response.has_session_object?("user"))
    assert_not_nil @bob, nil
    assert_equal @bob, @response.session["user"]
  end
  
  def test_signup
    @request.session['return-to'] = "/bogus/location"

    post :signup, "user" => { "login" => "newbob", "password" => "newpassword", "password_confirmation" => "newpassword" }
    assert(@response.has_session_object?("user"))
    
    assert_equal("http://localhost/bogus/location", @response.redirect_url)
  end

  def test_bad_signup
    @request.session['return-to'] = "/bogus/location"

    post :signup, :user => { "login" => "newbob", "password" => "newpassword", "password_confirmation" => "wrong" }
    assert(assigns(:user).errors.invalid?('password'))
#    assert_success
    
    post :signup, "user" => { "login" => "yo", "password" => "newpassword", "password_confirmation" => "newpassword" }
    assert(assigns(:user).errors.invalid?('login'))
#    assert_success
    post :signup, "user" => { "login" => "yo", "password" => "newpassword", "password_confirmation" => "wrong" }
    assert(assigns(:user).errors.invalid?('login'))
    assert(assigns(:user).errors.invalid?('password'))
#    assert_success
  end

  def test_invalid_login
    post :login, "user_login" => "bob", "user_password" => "not_correct"
    assert(!@response.has_session_object?("user"))
#    assert_template_has "message"
#    assert_template_has "login"
  end
  
  def test_login_logoff
    post :login, "user_login" => "bob", "user_password" => "test"
    assert(@response.has_session_object?("user"))
   # get :logout
   # assert_session_has_no "user"
  end
  
  def test_transfer_chips
    post :login, "user_login" => "bob", "user_password" => "test"
    @bob = @request.session['user']
    initial_chips = @bob.chips
    post :transfer_chips, "login" => ["longbob"], "amt" => "50"
    assert initial_chips, @bob.chips + 50 
  end  
end
