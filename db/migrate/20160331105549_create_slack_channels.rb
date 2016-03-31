class CreateSlackChannels < ActiveRecord::Migration
  def change
    create_table :slack_channels do |t|
      t.string :slack_channel_id
      t.string :name
      t.boolean :is_general
      t.boolean :is_archived
      t.boolean :is_channel
      t.datetime :created_date
      t.text :slack_code
      t.text :last_read
      t.integer :unread_count
      t.references :slack_team, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :slack_channels, :slack_channel_id
  end
end
