class CreateSlackCommands < ActiveRecord::Migration
  def change
    create_table :slack_commands do |t|
      t.text :response_url
      t.text :command
      t.text :query
      t.text :slack_code
      t.boolean :understand
      t.string :assigned_to

      t.timestamps null: false
    end
  end
end
