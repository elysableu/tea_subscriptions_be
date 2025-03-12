class Tea < ApplicationRecord
  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates :brew_time, presence: true

  # Relationships
  has_many :subscription_teas
  has_many :subscriptions, through: :subscription_teas
end