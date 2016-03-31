class CreateSlackTasks < ActiveRecord::Migration
  def change
    create_table :slack_tasks do |t|
      t.references :slack_team, index: true, foreign_key: true
      t.references :slack_user, index: true, foreign_key: true
      t.references :slack_channel, index: true, foreign_key: true
      t.text :slack_code
      t.text :raw_content
      t.text :task_description
      t.text :response_url
      t.boolean :is_done
      t.string :user_creator
      t.string :user_assigned

      t.timestamps null: false
    end
  end
end
