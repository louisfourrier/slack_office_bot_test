json.array!(@slack_tasks) do |slack_task|
  json.extract! slack_task, :id, :slack_team_id, :slack_user_id, :slack_channel_id, :slack_code, :raw_content, :task_description, :response_url, :is_done, :user_creator, :user_assigned
  json.url slack_task_url(slack_task, format: :json)
end
