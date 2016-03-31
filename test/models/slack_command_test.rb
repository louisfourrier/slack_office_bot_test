# == Schema Information
#
# Table name: slack_commands
#
#  id           :integer          not null, primary key
#  response_url :text
#  command      :text
#  query        :text
#  slack_code   :text
#  understand   :boolean
#  assigned_to  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class SlackCommandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
