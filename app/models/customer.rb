class Customer < ApplicationRecord
  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address, presence: true

  # Relationships
  has_many :subscription_customers
  has_many :subscriptions, through: :subscription_customers
end