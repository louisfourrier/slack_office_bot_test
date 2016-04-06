require 'test_helper'

class InstallationControllerTest < ActionController::TestCase
  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get support" do
    get :support
    assert_response :success
  end

  test "should get authorize" do
    get :authorize
    assert_response :success
  end

end
