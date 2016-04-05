# == Schema Information
#
# Table name: slack_commands
#
#  id                    :integer          not null, primary key
#  response_url          :text
#  command               :text
#  query                 :text
#  slack_code            :text
#  understand            :boolean
#  assigned_to           :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  original_token        :string
#  original_team_id      :string
#  original_team_domain  :string
#  original_channel_id   :string
#  original_channel_name :string
#  original_user_id      :string
#  original_user_name    :string
#  original_command      :string
#  original_text         :string
#  slack_team_id         :integer
#  slack_user_id         :integer
#  slack_channel_id      :integer
#

require 'test_helper'

class SlackCommandsControllerTest < ActionController::TestCase
  setup do
    @slack_command = slack_commands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slack_commands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slack_command" do
    assert_difference('SlackCommand.count') do
      post :create, slack_command: { assigned_to: @slack_command.assigned_to, command: @slack_command.command, query: @slack_command.query, response_url: @slack_command.response_url, slack_code: @slack_command.slack_code, understand: @slack_command.understand }
    end

    assert_redirected_to slack_command_path(assigns(:slack_command))
  end

  test "should show slack_command" do
    get :show, id: @slack_command
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slack_command
    assert_response :success
  end

  test "should update slack_command" do
    patch :update, id: @slack_command, slack_command: { assigned_to: @slack_command.assigned_to, command: @slack_command.command, query: @slack_command.query, response_url: @slack_command.response_url, slack_code: @slack_command.slack_code, understand: @slack_command.understand }
    assert_redirected_to slack_command_path(assigns(:slack_command))
  end

  test "should destroy slack_command" do
    assert_difference('SlackCommand.count', -1) do
      delete :destroy, id: @slack_command
    end

    assert_redirected_to slack_commands_path
  end
end
