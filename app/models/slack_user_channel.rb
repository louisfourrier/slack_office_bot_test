# == Schema Information
#
# Table name: slack_user_channels
#
#  id               :integer          not null, primary key
#  slack_user_id    :integer
#  slack_channel_id :integer
#  last_update      :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class SlackUserChannel < ActiveRecord::Base
  belongs_to :slack_user
  belongs_to :slack_channel
end
