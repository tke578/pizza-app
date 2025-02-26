# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


store_owner = User.new(email: "pizza.store.owner@strongmind.com", roles: [User::PIZZA_STORE_OWNER])
store_owner.password = "password1!"
store_owner.password_confirmation = "password1!"
store_owner.save
puts "***********Created Pizza Store Owner with email: pizza.store.owner@strongmind.com"
pizza_chef = User.new(email: "pizza.chef@strongmind.com", roles: [User::PIZZA_CHEF])
pizza_chef.password = "password1!"
pizza_chef.password_confirmation = "password1!"
pizza_chef.save
puts "***********Created Pizza Chef with email: pizza.chef@strongmind.com"
