class CorrectModelForSlack < ActiveRecord::Migration
  def change
    change_column :slack_teams, :slack_team_id, :string

    
    change_column :slack_users, :slack_user_id, :string

    add_column :slack_commands, :original_token, :string
    add_column :slack_commands, :original_team_id, :string
    add_column :slack_commands, :original_team_domain, :string
    add_column :slack_commands, :original_channel_id, :string
    add_column :slack_commands, :original_channel_name, :string
    add_column :slack_commands, :original_user_id, :string
    add_column :slack_commands, :original_user_name, :string
    add_column :slack_commands, :original_command, :string
    add_column :slack_commands, :original_text, :string

  end
end
