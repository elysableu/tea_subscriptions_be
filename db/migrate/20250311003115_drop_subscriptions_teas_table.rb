class DropSubscriptionsTeasTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :subscriptions_teas
  end
end
