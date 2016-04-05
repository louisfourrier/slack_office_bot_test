class AddDoneDateToTask < ActiveRecord::Migration
  def change
    add_column :slack_tasks, :done_date, :datetime
  end
end
