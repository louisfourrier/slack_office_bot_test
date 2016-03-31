# == Schema Information
#
# Table name: slack_channels
#
#  id               :integer          not null, primary key
#  slack_channel_id :string
#  name             :string
#  is_general       :boolean
#  is_archived      :boolean
#  is_channel       :boolean
#  created_date     :datetime
#  slack_code       :text
#  last_read        :text
#  unread_count     :integer
#  slack_team_id    :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class SlackChannelsControllerTest < ActionController::TestCase
  setup do
    @slack_channel = slack_channels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slack_channels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slack_channel" do
    assert_difference('SlackChannel.count') do
      post :create, slack_channel: { created_date: @slack_channel.created_date, is_archived: @slack_channel.is_archived, is_channel: @slack_channel.is_channel, is_general: @slack_channel.is_general, last_read: @slack_channel.last_read, name: @slack_channel.name, slack_channel_id: @slack_channel.slack_channel_id, slack_code: @slack_channel.slack_code, slack_team_id: @slack_channel.slack_team_id, unread_count: @slack_channel.unread_count }
    end

    assert_redirected_to slack_channel_path(assigns(:slack_channel))
  end

  test "should show slack_channel" do
    get :show, id: @slack_channel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slack_channel
    assert_response :success
  end

  test "should update slack_channel" do
    patch :update, id: @slack_channel, slack_channel: { created_date: @slack_channel.created_date, is_archived: @slack_channel.is_archived, is_channel: @slack_channel.is_channel, is_general: @slack_channel.is_general, last_read: @slack_channel.last_read, name: @slack_channel.name, slack_channel_id: @slack_channel.slack_channel_id, slack_code: @slack_channel.slack_code, slack_team_id: @slack_channel.slack_team_id, unread_count: @slack_channel.unread_count }
    assert_redirected_to slack_channel_path(assigns(:slack_channel))
  end

  test "should destroy slack_channel" do
    assert_difference('SlackChannel.count', -1) do
      delete :destroy, id: @slack_channel
    end

    assert_redirected_to slack_channels_path
  end
end
