# == Schema Information
#
# Table name: slack_users
#
#  id               :integer          not null, primary key
#  slack_team_id    :integer
#  slack_user_id    :string
#  name             :string
#  email            :string
#  color            :string
#  deleted          :boolean
#  profile          :text
#  is_admin         :boolean
#  is_owner         :boolean
#  is_primary_owner :boolean
#  slack_code       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class SlackUser < ActiveRecord::Base
  include CommonMethod

  has_many :slack_user_channels
  has_many :slack_channels, through: :slack_user_channels
  has_many :slack_commands
  has_many :slack_tasks

  belongs_to :slack_team

  validates :name,  presence: true
  validates :name, uniqueness: true
  validates :name, :uniqueness => {:scope => :slack_team_id}
  validates :slack_user_id, uniqueness: true, :allow_blank => true


end
