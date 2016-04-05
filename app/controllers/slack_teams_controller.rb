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

class SlackTeamsController < ApplicationController
  before_action :set_slack_team, only: [:show, :edit, :update, :destroy]

  # GET /slack_teams
  # GET /slack_teams.json
  def index
    @slack_teams = SlackTeam.all
  end

  # GET /slack_teams/1
  # GET /slack_teams/1.json
  def show
  end

  # GET /slack_teams/new
  def new
    @slack_team = SlackTeam.new
  end

  # GET /slack_teams/1/edit
  def edit
  end

  # POST /slack_teams
  # POST /slack_teams.json
  def create
    @slack_team = SlackTeam.new(slack_team_params)

    respond_to do |format|
      if @slack_team.save
        format.html { redirect_to @slack_team, notice: 'Slack team was successfully created.' }
        format.json { render :show, status: :created, location: @slack_team }
      else
        format.html { render :new }
        format.json { render json: @slack_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_teams/1
  # PATCH/PUT /slack_teams/1.json
  def update
    respond_to do |format|
      if @slack_team.update(slack_team_params)
        format.html { redirect_to @slack_team, notice: 'Slack team was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_team }
      else
        format.html { render :edit }
        format.json { render json: @slack_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_teams/1
  # DELETE /slack_teams/1.json
  def destroy
    @slack_team.destroy
    respond_to do |format|
      format.html { redirect_to slack_teams_url, notice: 'Slack team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack_team
      @slack_team = SlackTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_team_params
      params.require(:slack_team).permit(:slack_team_id, :team_domain, :company_name)
    end
end
