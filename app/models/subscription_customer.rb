class SubscriptionCustomer < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription
end