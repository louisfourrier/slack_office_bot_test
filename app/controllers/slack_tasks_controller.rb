# == Schema Information
#
# Table name: slack_tasks
#
#  id               :integer          not null, primary key
#  slack_team_id    :integer
#  slack_user_id    :integer
#  slack_channel_id :integer
#  slack_code       :text
#  raw_content      :text
#  task_description :text
#  response_url     :text
#  is_done          :boolean          default(FALSE)
#  user_creator     :string
#  user_assigned    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  channel_order    :integer
#  done_date        :datetime
#

class SlackTasksController < ApplicationController
  before_action :set_slack_task, only: [:show, :edit, :update, :destroy]

  # GET /slack_tasks
  # GET /slack_tasks.json
  def index
    @slack_tasks = SlackTask.all
  end

  # GET /slack_tasks/1
  # GET /slack_tasks/1.json
  def show
  end

  # GET /slack_tasks/new
  def new
    @slack_task = SlackTask.new
  end

  # GET /slack_tasks/1/edit
  def edit
  end

  # POST /slack_tasks
  # POST /slack_tasks.json
  def create
    @slack_task = SlackTask.new(slack_task_params)

    respond_to do |format|
      if @slack_task.save
        format.html { redirect_to @slack_task, notice: 'Slack task was successfully created.' }
        format.json { render :show, status: :created, location: @slack_task }
      else
        format.html { render :new }
        format.json { render json: @slack_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_tasks/1
  # PATCH/PUT /slack_tasks/1.json
  def update
    respond_to do |format|
      if @slack_task.update(slack_task_params)
        format.html { redirect_to @slack_task, notice: 'Slack task was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_task }
      else
        format.html { render :edit }
        format.json { render json: @slack_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_tasks/1
  # DELETE /slack_tasks/1.json
  def destroy
    @slack_task.destroy
    respond_to do |format|
      format.html { redirect_to slack_tasks_url, notice: 'Slack task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack_task
      @slack_task = SlackTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_task_params
      params.require(:slack_task).permit(:slack_team_id, :slack_user_id, :slack_channel_id, :slack_code, :raw_content, :task_description, :response_url, :is_done, :user_creator, :user_assigned)
    end
end
