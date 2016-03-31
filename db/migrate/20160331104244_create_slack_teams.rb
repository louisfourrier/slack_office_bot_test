class CreateSlackTeams < ActiveRecord::Migration
  def change
    create_table :slack_teams do |t|
      t.integer :slack_team_id
      t.string :team_domain
      t.string :company_name

      t.timestamps null: false
    end
  end
end
