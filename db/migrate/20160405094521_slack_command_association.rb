class SlackCommandAssociation < ActiveRecord::Migration
  def change
    add_column :slack_commands, :slack_team_id, :integer
    add_column :slack_commands, :slack_user_id, :integer
    add_column :slack_commands, :slack_channel_id, :integer


    add_index :slack_commands, :slack_team_id
    add_index :slack_commands, :slack_user_id
    add_index :slack_commands, :slack_channel_id


  end
end
