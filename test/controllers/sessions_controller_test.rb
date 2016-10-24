require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def login_a_merchant
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    get :create,  {provider: "google"}
  end

  test "Attempting to log in without email should send you to welcome page" do
    login_a_merchant
    request.env['omniauth.auth'][:info].delete(:email)

    assert_no_difference('Merchant.count') do
      get :create,  {provider: "google"}
    end
    assert_redirected_to sessions_path
  end

  test "Can Create a merchant" do
    assert_difference('Merchant.count', 1) do
      login_a_merchant

      assert_response :redirect
      assert_redirected_to sessions_path
      assert_not_nil session[:user_id]
    end
  end
  #
  # test "If a merchant logs in twice it doesn't create a 2nd merchant" do
  #   assert_difference('Merchant.count', 1) do
  #     login_a_merchant
  #   end
  #
  #   assert_no_difference('Merchant.count') do
  #     login_a_merchant
  #     assert_response :redirect
  #     assert_redirected_to sessions_path
  #     assert_not_nil session[:merchant_id]
  #   end
  # end
  #
  # test "If a merchant logs out merchant_id should be nil and should be redirected to the right place" do
  #   login_a_merchant
  #   get :destroy
  #
  #   assert_response :redirect
  #   assert_redirected_to root_path
  #   assert_nil session[:merchant_id]
  # end
end
