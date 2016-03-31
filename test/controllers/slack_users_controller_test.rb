# == Schema Information
#
# Table name: slack_users
#
#  id               :integer          not null, primary key
#  slack_team_id    :integer
#  slack_user_id    :integer
#  name             :string
#  email            :string
#  color            :string
#  deleted          :boolean
#  profile          :text
#  is_admin         :boolean
#  is_owner         :boolean
#  is_primary_owner :boolean
#  slack_code       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class SlackUsersControllerTest < ActionController::TestCase
  setup do
    @slack_user = slack_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slack_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slack_user" do
    assert_difference('SlackUser.count') do
      post :create, slack_user: { color: @slack_user.color, deleted: @slack_user.deleted, email: @slack_user.email, is_admin: @slack_user.is_admin, is_owner: @slack_user.is_owner, is_primary_owner: @slack_user.is_primary_owner, name: @slack_user.name, profile: @slack_user.profile, slack_code: @slack_user.slack_code, slack_team_id: @slack_user.slack_team_id, slack_user_id: @slack_user.slack_user_id }
    end

    assert_redirected_to slack_user_path(assigns(:slack_user))
  end

  test "should show slack_user" do
    get :show, id: @slack_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slack_user
    assert_response :success
  end

  test "should update slack_user" do
    patch :update, id: @slack_user, slack_user: { color: @slack_user.color, deleted: @slack_user.deleted, email: @slack_user.email, is_admin: @slack_user.is_admin, is_owner: @slack_user.is_owner, is_primary_owner: @slack_user.is_primary_owner, name: @slack_user.name, profile: @slack_user.profile, slack_code: @slack_user.slack_code, slack_team_id: @slack_user.slack_team_id, slack_user_id: @slack_user.slack_user_id }
    assert_redirected_to slack_user_path(assigns(:slack_user))
  end

  test "should destroy slack_user" do
    assert_difference('SlackUser.count', -1) do
      delete :destroy, id: @slack_user
    end

    assert_redirected_to slack_users_path
  end
end
