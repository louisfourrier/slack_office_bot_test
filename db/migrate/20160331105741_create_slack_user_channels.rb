class CreateSlackUserChannels < ActiveRecord::Migration
  def change
    create_table :slack_user_channels do |t|
      t.references :slack_user, index: true, foreign_key: true
      t.references :slack_channel, index: true, foreign_key: true
      t.datetime :last_update

      t.timestamps null: false
    end
  end
end
