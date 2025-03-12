class Subscription < ApplicationRecord
  # Validations
  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true

  # Relationships
  has_many :subscription_customers
  has_many :customers, through: :subscription_customers

  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  def self.valid_status?(id)
    subscription = Subscription.find(id)
    if subscription.status == "active"
      return true
    else
      return false
    end
  end
end