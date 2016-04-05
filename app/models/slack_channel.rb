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

  def list_tasks_payload
    tasks = self.slack_tasks
    title = "Liste de toutes les taches dans le channel: " + self.name.to_s
    payload = {
    "payload" => {
        response_type: "in_channel",
        text: title, # Text to be sent link into the string
        username: "TaskBotLouis", # Change the username name
        channel: self.slack_channel.slack_name, # For direct message or public channels
        attachments: [
          {
              title: self.task_description.to_s,
              title_link: "http://www.mensquare.com/avionsdechasse/avions/?type=avion&id=100762",
              fields: self.generate_tasks_json_array
          }
      ]
        }.to_json
    }

    return payload
  end

  def generate_tasks_json_array
      tasks = self.slack_tasks
      array = []
      tasks.each do |t|
        array << {
            title: "Task #{t.id}",
            value: t.task_description.to_s,
            short: true
        }
      end
      return array
  end


end
