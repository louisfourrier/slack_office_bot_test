# == Schema Information
#
# Table name: slack_commands
#
#  id                    :integer          not null, primary key
#  response_url          :text
#  command               :text
#  query                 :text
#  slack_code            :text
#  understand            :boolean
#  assigned_to           :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  original_token        :string
#  original_team_id      :string
#  original_team_domain  :string
#  original_channel_id   :string
#  original_channel_name :string
#  original_user_id      :string
#  original_user_name    :string
#  original_command      :string
#  original_text         :string
#  slack_team_id         :integer
#  slack_user_id         :integer
#  slack_channel_id      :integer
#

require 'test_helper'

class SlackCommandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
