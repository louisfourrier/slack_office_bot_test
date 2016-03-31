require 'test_helper'

class MeteoControllerTest < ActionController::TestCase
  test "should get slack_command" do
    get :slack_command
    assert_response :success
  end

end
