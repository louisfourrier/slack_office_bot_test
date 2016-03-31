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

module SlackChannelsHelper
end
