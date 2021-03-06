# == Schema Information
#
# Table name: slack_tasks
#
#  id                     :integer          not null, primary key
#  slack_team_id          :integer
#  slack_user_id          :integer
#  slack_channel_id       :integer
#  slack_code             :text
#  raw_content            :text
#  task_description       :text
#  response_url           :text
#  is_done                :boolean          default(FALSE)
#  user_creator           :string
#  user_assigned          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  channel_order          :integer
#  done_date              :datetime
#  slack_user_assigned_id :integer
#

class SlackTask < ActiveRecord::Base
  include CommonMethod

  belongs_to :slack_team
  belongs_to :slack_user
  belongs_to :slack_channel

  after_create :warn_slack_creation
  after_create :assign_channel_order

  has_many :slack_task_assignements
  has_many :slack_user_assigned, through: :slack_task_assignements, source: :slack_user

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
    stask.task_description = command.query.to_s
    stask.response_url = command.response_url.to_s
    stask.user_creator = command.slack_user.name
    if stask.save
      stask.assign_users(command)
    end
  end

  # Create or assign users in a task
  def assign_users(command)
    assigns = []
    if !command.assignment_arguments.empty?
      users = command.assignment_arguments
        users.each do |uname|
          u = command.slack_team.slack_users.find_by(name: uname.to_s.gsub('@', ''))
          if u.nil?
             u = command.slack_team.slack_users.create(name: uname.to_s.gsub('@', ''))
          end
          self.slack_user_assigned << u
        end
    end
  end

  # Mark a task as done
  def task_done
    self.update(:is_done => true, :done_date => Time.zone.now)
  end

  # Mark a task as undone
  def task_undone
    self.update(:is_done => false, :done_date => nil)
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
        title: "Task #{self.channel_order} : #{self.task_description.to_s}",
        text: "Created_at : #{self.created_at} by #{self.slack_user.name}",
        color: self.slack_color,
        fields: [
         {
             title: "Users Assigned",
             value: self.slack_user_assigned.pluck(:name).join(' '),
             short: true
         },
         {
             title: "Done ?",
             value: self.is_done.to_s,
             short: true
         }

       ]
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
                   value: "/todobot list (Liste toutes les taches de la channel)",
                   short: false
               },
               {
                   title: "Help",
                   value: "/todobot help (Aide sur les commandes possibles)",
                   short: false
               },
               {
                   title: "Done",
                   value: "/todobot done 2 4 6  (marque comme done les tasks 2 4 6)",
                   short: false
               },
               {
                   title: "Show",
                   value: "/todobot show (Comme liste mais visible par tout le monde)",
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
