class Customer < ApplicationRecord
  has_many :customers_subscriptions
  has_many :subscriptions, through: :customers_subscriptions
end