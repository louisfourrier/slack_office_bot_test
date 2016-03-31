# == Schema Information
#
# Table name: slack_teams
#
#  id            :integer          not null, primary key
#  slack_team_id :integer
#  team_domain   :string
#  company_name  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SlackTeam < ActiveRecord::Base
  has_many :slack_users
  has_many :slack_channels
  
end
