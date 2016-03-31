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

module SlackTasksHelper
end
