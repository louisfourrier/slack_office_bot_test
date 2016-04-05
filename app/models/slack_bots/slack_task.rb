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
#  is_done          :boolean
#  user_creator     :string
#  user_assigned    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class SlackTask < ActiveRecord::Base
  belongs_to :slack_team
  belongs_to :slack_user
  belongs_to :slack_channel

  after_create :warn_slack_creation

  def self.command_managed
    return ["todobot", "task"]
  end

  def self.keywords
    ['list', 'help', 'list done']
  end

  def self.handle_slack_command(command)
    if command.first_key_word == "list"
      channel = command.slack_channel
      payload = channel.list_tasks_payload
      SlackCommunication.send_payload(command.response_url.to_s, payload)
    elsif command.first_key_word == "help"
      payload = self.slack_help(command)
      SlackCommunication.send_payload(command.response_url.to_s, payload)
    else
      new_task = self.create_task_from_command(command)
    end
  end

  def self.create_task_from_command(command)
    stask = self.new
    stask.slack_team = command.slack_team
    stask.slack_user = command.slack_user
    stask.slack_channel = command.slack_channel
    stask.raw_content = command.query
    stask.is_done = false
    stask.task_description = command.query.to_s
    stask.response_url = command.response_url.to_s
    stask.save
  end

  def warn_slack_creation
    payload = {
    "payload" => {
        response_type: "ephemeral",
        text: "Création d'une nouvelle Tache", # Text to be sent link into the string
        username: "TaskBotLouis", # Change the username name
        channel: self.slack_channel.slack_name, # For direct message or public channels
        attachments: [
          {
              title: self.task_description.to_s,
              title_link: "http://www.mensquare.com/avionsdechasse/avions/?type=avion&id=100762",
              fields: [
               {
                   title: "Team",
                   value: self.slack_team.name,
                   short: true
               },
               {
                   title: "Channel",
                   value: self.slack_channel.name.to_s,
                   short: true
               },
               {
                   title: "Creator",
                   value: self.slack_user.name,
                   short: true
               }
             ],
          }
      ]
        }.to_json
    }
    SlackCommunication.send_payload(self.response_url.to_s, payload)
  end

  def self.slack_help(command)
    payload = {
    "payload" => {
        response_type: "ephemeral",
        text: "Documentation de TaskBotLouis", # Text to be sent link into the string
        username: "TaskBotLouis", # Change the username name
        channel: command.slack_channel.slack_name, # For direct message or public channels
        attachments: [
          {
              title: "Toutes les commandes possibles",
              fields: [
               {
                   title: "List",
                   value: "Liste toutes les taches de la channel",
                   short: true
               },
               {
                   title: "Help",
                   value: "Aide sur les commandes possibles",
                   short: true
               },
               {
                   title: "Show",
                   value: "Comme liste mais visible par tout le monde",
                   short: true
               }
             ],
          }
      ]
        }.to_json
    }
    return payload


  end


end
