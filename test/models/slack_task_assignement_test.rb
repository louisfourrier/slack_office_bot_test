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

require 'test_helper'

class SlackTaskAssignementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
