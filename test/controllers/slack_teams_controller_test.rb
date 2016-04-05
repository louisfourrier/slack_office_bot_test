# == Schema Information
#
# Table name: slack_teams
#
#  id            :integer          not null, primary key
#  slack_team_id :string
#  team_domain   :string
#  company_name  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class SlackTeamsControllerTest < ActionController::TestCase
  setup do
    @slack_team = slack_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slack_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slack_team" do
    assert_difference('SlackTeam.count') do
      post :create, slack_team: { company_name: @slack_team.company_name, slack_team_id: @slack_team.slack_team_id, team_domain: @slack_team.team_domain }
    end

    assert_redirected_to slack_team_path(assigns(:slack_team))
  end

  test "should show slack_team" do
    get :show, id: @slack_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slack_team
    assert_response :success
  end

  test "should update slack_team" do
    patch :update, id: @slack_team, slack_team: { company_name: @slack_team.company_name, slack_team_id: @slack_team.slack_team_id, team_domain: @slack_team.team_domain }
    assert_redirected_to slack_team_path(assigns(:slack_team))
  end

  test "should destroy slack_team" do
    assert_difference('SlackTeam.count', -1) do
      delete :destroy, id: @slack_team
    end

    assert_redirected_to slack_teams_path
  end
end
