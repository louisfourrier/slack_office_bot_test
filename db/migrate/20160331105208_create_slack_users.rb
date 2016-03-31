class CreateSlackUsers < ActiveRecord::Migration
  def change
    create_table :slack_users do |t|
      t.references :slack_team, index: true, foreign_key: true
      t.integer :slack_user_id
      t.string :name
      t.string :email
      t.string :color
      t.boolean :deleted
      t.text :profile
      t.boolean :is_admin
      t.boolean :is_owner
      t.boolean :is_primary_owner
      t.text :slack_code

      t.timestamps null: false
    end
  end
end
