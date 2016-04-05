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

# Classs that handle all the Slack Commands and dispatch it in all the relevant classes
class SlackCommand < ActiveRecord::Base
  belongs_to :slack_team
  belongs_to :slack_user
  belongs_to :slack_channel

  after_create :create_association_models

  # First Router of the command center.
  # Save the command and process it
  def self.handle_command(params)
    slack_command = self.create_from_params(params)
    if slack_command.valid?
      slack_command.save
      slack_command.process_command
      return true
    else
      return false
    end
  end

  # Dispatch Task to the correct Model or send a message of no understanding
  def process_command
    if command == "/todobot"
      SlackTask.handle_slack_command(self)
    else
      self.send_message_response("Nous sommmes en train de développer la gestion des commandes sur la plateforme Slack, nous reviendrons avec des réponses bientôt...")
    end
  end

  def first_key_word
    words = self.query.to_s.split(' ')
    return words.first
  end

  # Create a command from the params of Slack
  def self.create_from_params(pr)
    # Create from params
    slack_command = SlackCommand.new(response_url: pr["response_url"], query: pr["text"], command: pr["command"], slack_code:pr, original_token: pr["token"], original_team_id: pr["team_id"], original_team_domain: pr["team_domain"], original_channel_id: pr["channel_id"],
    original_channel_name: pr["channel_name"],  original_user_id: pr["user_id"], original_user_name: pr["user_name"], original_command: pr["command"], original_text: pr["text"])
    return slack_command
  end

  def send_message_response(message)
    json_params = {
    "payload" => {
        text: message.to_s, # Text to be sent link into the string
        username: "SlackCommandService",
        mrkdwn: false
    }.to_json
  }
    self.send_payload_response(json_params)
  end

  def send_payload_response(pay_load)
    puts "Send command answer"
    uri = URI.parse(self.response_url.to_s)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(pay_load)
    response = http.request(request)
    puts response.to_s
  end

  # Create and/or associate association models for the Slack Command
  def create_association_models
    st = SlackTeam.find_by(slack_team_id: self.original_team_id.to_s)
    if st.nil?
      st = SlackTeam.create(slack_team_id: self.original_team_id.to_s, team_domain: self.original_team_domain.to_s)
    end

    sc = st.slack_channels.find_by(slack_channel_id: self.original_channel_id.to_s)
    if sc.nil?
      sc = st.slack_channels.create(slack_channel_id: self.original_channel_id.to_s, name: self.original_channel_name.to_s)
    end

    su = st.slack_users.find_by(slack_user_id: self.original_user_id.to_s)
    if su.nil?
      su = st.slack_users.create(slack_user_id: self.original_user_id.to_s, name: self.original_user_name.to_s)
    end

    self.update_columns(slack_team_id: st.id, slack_user_id: su.id, slack_channel_id: sc.id )
  end





end
