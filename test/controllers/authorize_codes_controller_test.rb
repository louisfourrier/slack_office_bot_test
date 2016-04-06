# == Schema Information
#
# Table name: authorize_codes
#
#  id         :integer          not null, primary key
#  code       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AuthorizeCodesControllerTest < ActionController::TestCase
  setup do
    @authorize_code = authorize_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authorize_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authorize_code" do
    assert_difference('AuthorizeCode.count') do
      post :create, authorize_code: { code: @authorize_code.code }
    end

    assert_redirected_to authorize_code_path(assigns(:authorize_code))
  end

  test "should show authorize_code" do
    get :show, id: @authorize_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authorize_code
    assert_response :success
  end

  test "should update authorize_code" do
    patch :update, id: @authorize_code, authorize_code: { code: @authorize_code.code }
    assert_redirected_to authorize_code_path(assigns(:authorize_code))
  end

  test "should destroy authorize_code" do
    assert_difference('AuthorizeCode.count', -1) do
      delete :destroy, id: @authorize_code
    end

    assert_redirected_to authorize_codes_path
  end
end
