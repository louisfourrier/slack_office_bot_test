# == Schema Information
#
# Table name: slack_teams
#
#  id            :integer          not null, primary key
#  slack_team_id :string
#  team_domain   :string
#  company_name  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SlackTeam < ActiveRecord::Base
  include CommonMethod
  
  has_many :slack_users
  has_many :slack_channels
  has_many :slack_commands
  has_many :slack_tasks

  validates :slack_team_id, :team_domain, presence: true
  validates :slack_team_id, uniqueness: true

  def name
    return self.team_domain.to_s
  end


end
