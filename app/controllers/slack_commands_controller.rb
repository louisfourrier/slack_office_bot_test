# == Schema Information
#
# Table name: slack_commands
#
#  id           :integer          not null, primary key
#  response_url :text
#  command      :text
#  query        :text
#  slack_code   :text
#  understand   :boolean
#  assigned_to  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class SlackCommandsController < ApplicationController
  before_action :set_slack_command, only: [:show, :edit, :update, :destroy]

  # GET /slack_commands
  # GET /slack_commands.json
  def index
    @slack_commands = SlackCommand.all
  end

  # GET /slack_commands/1
  # GET /slack_commands/1.json
  def show
  end

  # GET /slack_commands/new
  def new
    @slack_command = SlackCommand.new
  end

  # GET /slack_commands/1/edit
  def edit
  end

  # POST /slack_commands
  # POST /slack_commands.json
  def create
    @slack_command = SlackCommand.new(slack_command_params)

    respond_to do |format|
      if @slack_command.save
        format.html { redirect_to @slack_command, notice: 'Slack command was successfully created.' }
        format.json { render :show, status: :created, location: @slack_command }
      else
        format.html { render :new }
        format.json { render json: @slack_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_commands/1
  # PATCH/PUT /slack_commands/1.json
  def update
    respond_to do |format|
      if @slack_command.update(slack_command_params)
        format.html { redirect_to @slack_command, notice: 'Slack command was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_command }
      else
        format.html { render :edit }
        format.json { render json: @slack_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_commands/1
  # DELETE /slack_commands/1.json
  def destroy
    @slack_command.destroy
    respond_to do |format|
      format.html { redirect_to slack_commands_url, notice: 'Slack command was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack_command
      @slack_command = SlackCommand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_command_params
      params.require(:slack_command).permit(:response_url, :command, :query, :slack_code, :understand, :assigned_to)
    end
end
