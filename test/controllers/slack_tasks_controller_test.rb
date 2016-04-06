# == Schema Information
#
# Table name: slack_tasks
#
#  id                     :integer          not null, primary key
#  slack_team_id          :integer
#  slack_user_id          :integer
#  slack_channel_id       :integer
#  slack_code             :text
#  raw_content            :text
#  task_description       :text
#  response_url           :text
#  is_done                :boolean          default(FALSE)
#  user_creator           :string
#  user_assigned          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  channel_order          :integer
#  done_date              :datetime
#  slack_user_assigned_id :integer
#

require 'test_helper'

class SlackTasksControllerTest < ActionController::TestCase
  setup do
    @slack_task = slack_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slack_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slack_task" do
    assert_difference('SlackTask.count') do
      post :create, slack_task: { is_done: @slack_task.is_done, raw_content: @slack_task.raw_content, response_url: @slack_task.response_url, slack_channel_id: @slack_task.slack_channel_id, slack_code: @slack_task.slack_code, slack_team_id: @slack_task.slack_team_id, slack_user_id: @slack_task.slack_user_id, task_description: @slack_task.task_description, user_assigned: @slack_task.user_assigned, user_creator: @slack_task.user_creator }
    end

    assert_redirected_to slack_task_path(assigns(:slack_task))
  end

  test "should show slack_task" do
    get :show, id: @slack_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slack_task
    assert_response :success
  end

  test "should update slack_task" do
    patch :update, id: @slack_task, slack_task: { is_done: @slack_task.is_done, raw_content: @slack_task.raw_content, response_url: @slack_task.response_url, slack_channel_id: @slack_task.slack_channel_id, slack_code: @slack_task.slack_code, slack_team_id: @slack_task.slack_team_id, slack_user_id: @slack_task.slack_user_id, task_description: @slack_task.task_description, user_assigned: @slack_task.user_assigned, user_creator: @slack_task.user_creator }
    assert_redirected_to slack_task_path(assigns(:slack_task))
  end

  test "should destroy slack_task" do
    assert_difference('SlackTask.count', -1) do
      delete :destroy, id: @slack_task
    end

    assert_redirected_to slack_tasks_path
  end
end
