require "#{File.dirname(__FILE__)}/../test_helper"

class StoriesTest < ActionController::IntegrationTest
  fixtures :users
  def test_story_one
    go_to_login
    play_blackjack
    play_video_poker
  end
  private

    def go_to_login
      post '/account/login', :user_login => 'bob', :user_password => 'test'
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template "lobby/games"
    end
    
    def play_blackjack
      get '/blackjack/show'
      assert_response :success
      post '/blackjack/bet', :bet => 5
      assert_response :success
    end
    # Note: A good security vulnerability would be a build in set of "Test Hands" that leak out into production
    def play_video_poker
      get '/video_poker/show'
      assert_response :success
      post '/video_poker/bet', :bet => 5
      assert_response :success
      post '/video_poker/draw', :hold_0 => false, :hold_1 => true, :hold_2 => true, :hold_3 => true,:hold_4 => true
      assert_response :success
    end
    
  end

  