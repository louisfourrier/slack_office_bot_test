json.array!(@slack_commands) do |slack_command|
  json.extract! slack_command, :id, :response_url, :command, :query, :slack_code, :understand, :assigned_to
  json.url slack_command_url(slack_command, format: :json)
end
