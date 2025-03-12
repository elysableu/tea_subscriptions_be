require "rails_helper"

RSpec.describe "Subscriptions Endpoints" do
  before(:each) do
    Customer.create!(first_name: "Beatrice", last_name: "Sipwell", email: "sipwell12@gmail.com", address: "88 Camellia Drive")
    Customer.create!(first_name: "Theo", last_name: "Brewster", email: "tBrew98@gmail.com", address: "222 Jasmine Circle")
    Customer.create!(first_name: "Ivy", last_name: "Wildbrew", email: "ivy.wild17@gmail.com", address: "89 Forest Terrace")

    Tea.create!(title: "Lady Grey", description: "Earl grey tea with vanilla and lavender", temperature: 200.00, brew_time: "3-5 minutes")
    Tea.create!(title: "Autumn Chai", description: "Vanilla and spice chai", temperature: 200.00, brew_time: "3-5 minutes")
    Tea.create!(title: "Tropical Bliss", description: "Coconut and lychee green tea" , temperature: 170.00, brew_time: "2-3 minutes")
    Tea.create!(title: "Sweet Biscotti", description: "Almond and vanilla black tea", temperature: 200.00, brew_time: "3-5 minutes")
    Tea.create!(title: "English Garden", description: "Rose petal black tea", temperature: 200.00, brew_time: "3-5 minutes")
    Tea.create!(title: "Velvet Truffle", description: "Black time with raspberry and dark chocolate", temperature: 200.00, brew_time: "3-5 minutes")

    @sub1 = Subscription.create!(title: "Afternoon tea time", price: 14.99, status: "active", frequency: "every month")
    @sub2 = Subscription.create!(title: "Around the World", price: 24.99, status: "canceled", frequency: "every two months")

    customers = Customer.all
    subscriptions = Subscription.all
    teas = Tea.all

    customers[0].subscriptions << subscriptions[0]
    customers[1].subscriptions << subscriptions[0]
    customers[1].subscriptions << subscriptions[1]
    customers[2].subscriptions << subscriptions[1]

    subscriptions[0].teas << teas[0]
    subscriptions[0].teas << teas[4]
    subscriptions[0].teas << teas[5]

    subscriptions[1].teas << teas[1]
    subscriptions[1].teas << teas[2]
    subscriptions[1].teas << teas[3]
  end

  describe "GET all subscriptions" do
    it "can retrieve all subscriptions" do
      get "/api/v1/subscriptions"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(2)
      
      json[:data].each do |subscription|
        expect(subscription).to have_key :id
        expect(subscription[:type]).to eq("subscription")
        expect(subscription[:attributes]).to have_key :title
        expect(subscription[:attributes]).to have_key :price
        expect(subscription[:attributes]).to have_key :status
        expect(subscription[:attributes]).to have_key :frequency
      end
    end
  end

  describe "GET details for one subscription" do
    it "can retrieve the details of one subscription" do
      get "/api/v1/subscriptions/#{@sub1.id}"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      subscription = json[:data]

      # Returns subscription deletes
      expect(subscription[:id]).to eq(@sub1.id.to_s)
      expect(subscription[:type]).to eq("subscription")
      expect(subscription[:attributes][:title]).to eq('Afternoon tea time')
      expect(subscription[:attributes][:price]).to eq('14.99')
      expect(subscription[:attributes][:status]).to eq('active')
      expect(subscription[:attributes][:frequency]).to eq('every month')
    end

    it "can retrieve the one subscriptions teas" do
      get "/api/v1/subscriptions/#{@sub1.id}"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      subscription = json[:data]

       # Returns subscriptions relationships
      expect(subscription[:relationships]).to have_key :teas

      subscription[:relationships][:teas][:data].each do |tea|
        expect(tea).to have_key :id
        expect(tea).to have_key :type
        expect(tea[:type]).to eq('tea')
      end

      # Returns Subscription_Teas details
      expect(json[:included].count).to eq(5)
      
      json[:included].each do |entry|
        expect(entry).to have_key :id
        expect(entry).to have_key :type

        if entry[:type] === 'tea'
          expect(entry[:attributes]).to have_key :title
          expect(entry[:attributes]).to have_key :description
          expect(entry[:attributes]).to have_key :temperature
          expect(entry[:attributes]).to have_key :brew_time
        end
      end
    end

    it "can retrieve the one subscriptions customers" do
      get "/api/v1/subscriptions/#{@sub1.id}"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      subscription = json[:data]

      expect(subscription[:relationships]).to have_key :customers

      subscription[:relationships][:customers][:data].each do |customer|
        expect(customer).to have_key :id
        expect(customer).to have_key :type
        expect(customer[:type]).to eq('customer')
      end
      
      expect(json[:included].count).to eq(5)

      # Returns Subscription_Customers details
      json[:included].each do |entry|
        expect(entry).to have_key :id
        expect(entry).to have_key :type

        if entry[:type] === 'customer'
          expect(entry[:attributes]).to have_key :first_name
          expect(entry[:attributes]).to have_key :last_name
          expect(entry[:attributes]).to have_key :email
          expect(entry[:attributes]).to have_key :address
        end
      end
    end

    describe "PATCH subscription to change the active status of a subscription" do
      it "changes a susbscription status to canceled" do
        status_update = {status: "canceled"}

        patch "/api/v1/subscriptions/#{@sub1.id}", 
          headers: {"CONTENT_TYPE" => "application/json"}, 
          params: JSON.generate({ subscription: status_update})
        
        expect(response).to be_successful

        subscription = Subscription.find(@sub1.id)

        expect(subscription.status).to_not eq("active")
        expect(subscription.status).to eq("canceled")
      end
    end
  end

  describe "Sad Paths" do
    it "returns an error if subscription can not be found" do
        test_id = 999

        get "/api/v1/subscriptions/#{test_id}"

        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(:not_found)
        expect(json[:message]).to eq("Subscription not found!")
        expect(json[:status]).to eq(404)
    end

    it "returns an error if user tries to set status to cancelled when it already is" do
      status_update = {status: "canceled"}

      patch "/api/v1/subscriptions/#{@sub2.id}", 
        headers: {"CONTENT_TYPE" => "application/json"}, 
        params: JSON.generate({ subscription: status_update})

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:bad_request)
        expect(json[:message]).to eq("Subscription already canceled!")
        expect(json[:status]).to eq(400)
    end
  end
end