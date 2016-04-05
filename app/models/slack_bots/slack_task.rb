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
#

class SlackTask < ActiveRecord::Base
  belongs_to :slack_team
  belongs_to :slack_user
  belongs_to :slack_channel

  after_create :warn_slack_creation
  after_create :assign_channel_order

  scope :done, -> { where(is_done: true) }
  scope :not_done, -> { where(is_done: false) }

  def self.command_managed
    return ["todobot", "task"]
  end

  def self.keywords
    ['list', 'help', 'show']
  end

  def self.handle_slack_command(command)
    if command.first_keyword == "list"
      channel = command.slack_channel
      payload = channel.list_tasks_payload
      SlackCommunication.send_payload(command.response_url.to_s, payload)
    elsif command.first_keyword == "show"
      channel = command.slack_channel
      payload = channel.list_tasks_payload(true)
      SlackCommunication.send_payload(command.response_url.to_s, payload)
    elsif command.first_keyword == "done"
      channel = command.slack_channel
      payload = channel.mark_as_done(command)
      SlackCommunication.send_payload(command.response_url.to_s, payload)
    elsif command.first_keyword == "help"
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
    stask.user_creator = command.slack_user.name
    stask.save
  end

  # Mark a task as done
  def task_done
    self.update(:is_done => true)
  end

  def slack_color
    if self.is_done
      return "good"
    else
      return "danger"
    end
  end

  # Return the task in the json format
  def to_slack_json
    json = {
        title: "Task #{self.channel_order}",
        text: self.task_description.to_s,
        color: self.slack_color,
        author_name: self.user_creator
    }
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
                   short: false
               },
               {
                   title: "Channel",
                   value: self.slack_channel.name.to_s,
                   short: false
               },
               {
                   title: "Creator",
                   value: self.slack_user.name,
                   short: false
               },
               {
                   title: "Done ?",
                   value: self.is_done.to_s,
                   short: false
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
                   short: false
               },
               {
                   title: "Help",
                   value: "Aide sur les commandes possibles",
                   short: false
               },
               {
                   title: "Show",
                   value: "Comme liste mais visible par tout le monde",
                   short: false
               }
             ],
          }
      ]
        }.to_json
    }
    return payload
  end



  # Assign the order of the task  in the channel
  def assign_channel_order
    nb_tasks = self.slack_channel.slack_tasks.count
    channel_order = nb_tasks + 1
    self.update_column(:channel_order, channel_order)
  end


end
