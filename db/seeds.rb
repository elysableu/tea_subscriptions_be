# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Customer.create!(first_name: "Beatrice", last_name: "Sipwell", email: "sipwell12@gmail.com", address: "88 Camellia Drive")
Customer.create!(first_name: "Theo", last_name: "Brewster", email: "tBrew98@gmail.com", address: "222 Jasmine Circle")
Customer.create!(first_name: "Ivy", last_name: "Wildbrew", email: "ivy.wild17@gmail.com", address: "89 Forest Terrace")

Tea.create!(title: "Lady Grey", description: "Earl grey tea with vanilla and lavender", temperature: 200.00, brew_time: "3-5 minutes")
Tea.create!(title: "Autumn Chai", description: "Vanilla and spice chai", temperature: 200.00, brew_time: "3-5 minutes")
Tea.create!(title: "Tropical Bliss", description: "Coconut and lychee green tea" , temperature: 170.00, brew_time: "2-3 minutes")
Tea.create!(title: "Sweet Biscotti", description: "Almond and vanilla black tea", temperature: 200.00, brew_time: "3-5 minutes")
Tea.create!(title: "English Garden", description: "Rose petal black tea", temperature: 200.00, brew_time: "3-5 minutes")
Tea.create!(title: "Velvet Truffle", description: "Black time with raspberry and dark chocolate", temperature: 200.00, brew_time: "3-5 minutes")

Subscription.create!(title: "Afternoon tea time", price: 14.99, status: "active", frequency: "every month")
Subscription.create!(title: "Around the World", price: 24.99, status: "active", frequency: "every two months")

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