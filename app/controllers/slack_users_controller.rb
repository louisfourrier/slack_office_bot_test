# == Schema Information
#
# Table name: slack_users
#
#  id               :integer          not null, primary key
#  slack_team_id    :integer
#  slack_user_id    :string
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

class SlackUsersController < ApplicationController
  before_action :set_slack_user, only: [:show, :edit, :update, :destroy]

  # GET /slack_users
  # GET /slack_users.json
  def index
    @slack_users = SlackUser.all
  end

  # GET /slack_users/1
  # GET /slack_users/1.json
  def show
  end

  # GET /slack_users/new
  def new
    @slack_user = SlackUser.new
  end

  # GET /slack_users/1/edit
  def edit
  end

  # POST /slack_users
  # POST /slack_users.json
  def create
    @slack_user = SlackUser.new(slack_user_params)

    respond_to do |format|
      if @slack_user.save
        format.html { redirect_to @slack_user, notice: 'Slack user was successfully created.' }
        format.json { render :show, status: :created, location: @slack_user }
      else
        format.html { render :new }
        format.json { render json: @slack_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_users/1
  # PATCH/PUT /slack_users/1.json
  def update
    respond_to do |format|
      if @slack_user.update(slack_user_params)
        format.html { redirect_to @slack_user, notice: 'Slack user was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_user }
      else
        format.html { render :edit }
        format.json { render json: @slack_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_users/1
  # DELETE /slack_users/1.json
  def destroy
    @slack_user.destroy
    respond_to do |format|
      format.html { redirect_to slack_users_url, notice: 'Slack user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack_user
      @slack_user = SlackUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_user_params
      params.require(:slack_user).permit(:slack_team_id, :slack_user_id, :name, :email, :color, :deleted, :profile, :is_admin, :is_owner, :is_primary_owner, :slack_code)
    end
end
