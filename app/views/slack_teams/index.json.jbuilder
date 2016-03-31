json.array!(@slack_teams) do |slack_team|
  json.extract! slack_team, :id, :slack_team_id, :team_domain, :company_name
  json.url slack_team_url(slack_team, format: :json)
end
