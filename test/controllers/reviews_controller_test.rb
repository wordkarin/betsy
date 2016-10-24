require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  # def login_a_user
  # request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  # get :create,  {provider: "google"}
  # end

  test "should get index" do
    
    get :index
    assert_response :success
  end


end
