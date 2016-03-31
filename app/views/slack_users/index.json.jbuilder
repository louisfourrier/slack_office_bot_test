json.array!(@slack_users) do |slack_user|
  json.extract! slack_user, :id, :slack_team_id, :slack_user_id, :name, :email, :color, :deleted, :profile, :is_admin, :is_owner, :is_primary_owner, :slack_code
  json.url slack_user_url(slack_user, format: :json)
end
