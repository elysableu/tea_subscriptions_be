class DropCustomersSubscriptionsTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :customers_subscriptions
  end
end
