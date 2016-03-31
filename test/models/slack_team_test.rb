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

require 'test_helper'

class SlackTeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
