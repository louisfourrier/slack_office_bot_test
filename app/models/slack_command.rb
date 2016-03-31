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

class SlackCommand < ActiveRecord::Base

  def self.handle_command(params)
    command = params["command"]
    query = params["text"]
    response_url = params["response_url"]
    # Create from params
    slack_command = self.create(response_url: response_url, query: query, command: command, slack_code:params)
    slack_command.process_command
  end

  def process_command
    self.send_message_response("Nous sommmes en train de développer la gestion des commandes sur la plateforme Slack, nous reviendrons avec des réponses bientôt...")

  end

  def new_process_command

  end

  def send_message_response(message)
    pay_load = {
        text: message.to_s, # Text to be sent link into the string
        username: "SlackCommandService",
        mrkdwn: true
    }
    self.send_payload_response(pay_load)
  end

  def send_payload_response(pay_load)
    puts "Send command answer"
    uri = URI.parse(self.response_url.to_s)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(pay_load)
    response = http.request(request)
  end


end
