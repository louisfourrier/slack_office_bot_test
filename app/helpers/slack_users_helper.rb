# == Schema Information
#
# Table name: slack_users
#
#  id               :integer          not null, primary key
#  slack_team_id    :integer
#  slack_user_id    :integer
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

module SlackUsersHelper
end
