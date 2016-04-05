class AddChannelOrderToTask < ActiveRecord::Migration
  def change
    add_column :slack_tasks, :channel_order, :integer
    change_column :slack_tasks, :is_done, :boolean, default: false
    
  end
end
