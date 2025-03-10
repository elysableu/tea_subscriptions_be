class CreateJoinTableSubscriptionCustomer < ActiveRecord::Migration[7.2]
  def change
    create_join_table :subscriptions, :customers do |t|
      t.index [:subscription_id, :customer_id]
      t.index [:customer_id, :subscription_id]
    end
  end
end
