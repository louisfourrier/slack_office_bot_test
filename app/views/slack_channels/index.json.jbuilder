json.array!(@slack_channels) do |slack_channel|
  json.extract! slack_channel, :id, :slack_channel_id, :name, :is_general, :is_archived, :is_channel, :created_date, :slack_code, :last_read, :unread_count, :slack_team_id
  json.url slack_channel_url(slack_channel, format: :json)
end
