class SlackTask < ActiveRecord::Base
  belongs_to :slack_team
  belongs_to :slack_user
  belongs_to :slack_channel
end
