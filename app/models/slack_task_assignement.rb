# == Schema Information
#
# Table name: slack_task_assignements
#
#  id            :integer          not null, primary key
#  slack_task_id :integer
#  slack_user_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SlackTaskAssignement < ActiveRecord::Base
  belongs_to :slack_task
  belongs_to :slack_user

  validates :slack_user_id, :slack_task_id, presence: true
end
