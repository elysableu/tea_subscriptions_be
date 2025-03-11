require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it {should have_many :subscription_customers}
    it {should have_many(:customers).through(:subscription_customers)}

    it {should have_many :subscription_teas}
    it {should have_many(:teas).through(:subscription_teas)}
  end
end