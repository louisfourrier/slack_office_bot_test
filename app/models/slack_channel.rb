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

class SlackChannel < ActiveRecord::Base
  belongs_to :slack_team
  has_many :slack_commands
  has_many :slack_tasks

  validates :name, :slack_channel_id, presence: true
  validates :name, :slack_channel_id, uniqueness: true


  def slack_name
    return "#" + self.name.to_s
  end

  # Return Payload for all the tasks in the Channel
  def list_tasks_payload(show_mode = false)
    tasks = self.slack_tasks
    title = "Liste de toutes les taches dans le channel: " + self.name.to_s
    payload = {
    "payload" => {
        response_type: "ephemeral",
        text: title, # Text to be sent link into the string
        username: "TaskBotLouis", # Change the username name
        channel: self.slack_name, # For direct message or public channels
        attachments: [
          {
              fields: self.generate_tasks_json_array
          }
      ]
        }.to_json
    }
    # See by everybody in the channel
    if show_mode
      payload = {
      "payload" => {
          response_type: "in_channel",
          text: title, # Text to be sent link into the string
          username: "TaskBotLouis", # Change the username name
          channel: self.slack_name, # For direct message or public channels
          attachments: [
            {
                fields: self.generate_tasks_json_array
            }
        ]
          }.to_json
      }
    end

    return payload
  end

  # Mark the Task as Done
  def mark_as_done(command)
    tasks_done = command.arguments_array
    tasks_array = []
    self.slack_tasks.where("slack_tasks.channel_order IN (?)", tasks_done.to_a).each do |t|
      t.task_done
      tasks_array << t.channel_order
    end
    title = "Les taches suivantes on été marquées comme complétées : "
    payload = {
    "payload" => {
        response_type: "in_channel",
        text: title, # Text to be sent link into the string
        username: "TaskBotLouis", # Change the username name
        channel: self.slack_name, # For direct message or public channels
        attachments: [
          {
            title: "Taches complétées : ",
            text: tasks_array.join(' '),
            color: 'good',
            author_name: command.slack_user.name,
          }
      ]
        }.to_json
    }
    return payload
  end


  def generate_tasks_json_array
      array = []
      self.slack_tasks.each do |t|
        color = t.slack_color
        array << t.to_slack_json
      end
      return array
  end

end
