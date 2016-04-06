class CreateSlackTaskAssignements < ActiveRecord::Migration
  def change
    create_table :slack_task_assignements do |t|
      t.references :slack_task, index: true, foreign_key: true
      t.references :slack_user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
