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

class SlackChannelsController < ApplicationController
  before_action :set_slack_channel, only: [:show, :edit, :update, :destroy]

  # GET /slack_channels
  # GET /slack_channels.json
  def index
    @slack_channels = SlackChannel.search_and_paginate(params)
  end

  # GET /slack_channels/1
  # GET /slack_channels/1.json
  def show
  end

  # GET /slack_channels/new
  def new
    @slack_channel = SlackChannel.new
  end

  # GET /slack_channels/1/edit
  def edit
  end

  # POST /slack_channels
  # POST /slack_channels.json
  def create
    @slack_channel = SlackChannel.new(slack_channel_params)

    respond_to do |format|
      if @slack_channel.save
        format.html { redirect_to @slack_channel, notice: 'Slack channel was successfully created.' }
        format.json { render :show, status: :created, location: @slack_channel }
      else
        format.html { render :new }
        format.json { render json: @slack_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_channels/1
  # PATCH/PUT /slack_channels/1.json
  def update
    respond_to do |format|
      if @slack_channel.update(slack_channel_params)
        format.html { redirect_to @slack_channel, notice: 'Slack channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_channel }
      else
        format.html { render :edit }
        format.json { render json: @slack_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_channels/1
  # DELETE /slack_channels/1.json
  def destroy
    @slack_channel.destroy
    respond_to do |format|
      format.html { redirect_to slack_channels_url, notice: 'Slack channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack_channel
      @slack_channel = SlackChannel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_channel_params
      params.require(:slack_channel).permit(:slack_channel_id, :name, :is_general, :is_archived, :is_channel, :created_date, :slack_code, :last_read, :unread_count, :slack_team_id)
    end
end
