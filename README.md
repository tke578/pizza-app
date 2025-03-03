Pizza Paradise App

Production Release https://pizza-app-420-63b82e28cb8f.herokuapp.com/

* Pizza Store Owners can create toppings for pizzas to be made and modify existing toppings
* Pizza Chefs can make pizzas with the toppings of their choice from the Pizza Store Owner selection and modify existing pizzas

![image](https://github.com/user-attachments/assets/ecf5335e-c4e6-4451-be55-f2e53aba7507)

To run locally

1. Clone the repo and make sure have ruby version `3.2.2` and rails `8.0.1`
2. Install Postgres
3. You might need to create a postgres user or the `$USER` on your local machine, `psql -U postgres`
![image](https://github.com/user-attachments/assets/cf508f5d-d63f-4c76-9efc-902f13902334)
4. `bundle install`
5. Create the database `rails db:create`
6. Run the migrations `rails db:migrate`
7. Run the seeds data for the pizza store owner and pizza chefs
8. To login, `/users/sign_in` there are two login user interfaces,
   
   a. Pizza Store Owner has a login email `pizza.store.owner@strongmind.com` pw is `password1! `
   
   b. Pizza Chefs has a login email `pizza.chef@strongmind.com` pw is `password1!`

Pizza Store Owner Interface
![image](https://github.com/user-attachments/assets/a0bb3850-d485-4a9a-9564-fe7b85b31efb)

Pizza Chefs Interface
![image](https://github.com/user-attachments/assets/95038f74-d5e8-4d3f-b42d-761e1bd831af)

9. Start rails server `bin/rails s` visit `localhost:3000`

To run tests
`bin/rails test test`

![image](https://github.com/user-attachments/assets/7761f514-379d-49f2-8985-70e1556413c4)

Runs all the unit tests from `/test`

Strategy of Attack

After gathering all the necessary acceptence criteria and clearing up ambuiguity, I had a clear picture to start on
The database schema would be as follows
Users - email, password, roles
Toppings - name
Pizzas - name
PizzaTopping - join table of topping and pizza

Users
   1. I've identified 2 user roles `pizzza_store_owner` and `pizza_chefs` and used Petergate https://github.com/elorest/petergate to manage the user roles.
   2. Since the story did not mentioned a user creation interfaced, I assumed there would be users already created hence the seed data.
   3. Devise for user authentication
Toppings
   1. Topping name was the only attribute we need to know
   2. Pizza Store Owners can only peform the CRUD actions so I had to make sure users with `Pizza Store Owner` are only allowed via the `access [User::PIZZA_STORE OWNER] => :all from petergate
   3. Added tests to validate
   4. I like using constants for user roles because it allows subtle changes to be only modified in one place(user model)
   5. Since Toppings can appear in many pizzas, added association `has_many :pizzas` and join table relation  has_many :pizza_toppings, `:dependent => destroy`. The dependent destory would allow `pizza_topping` to be deleted if a topping was removed.

Pizzas
   1. Pizza name was the only attribute we need to know
   2. Pizza Chefs can only peform the CRUD actions so I had to make sure users with `Pizza Chef` are only allowed via the `access [User::PIZZA_CHEF] => :all` from petergate
   3. Added tests to validate
   4. Pizza can have many toppings so I added a dropdown select on the Pizza form for the user to choose. The form selection passes the toppings as id's to the controller to create the join table `pizza_toppings`
   5. Tests were added for these

PizzaToppings
  1. This forms the join table between pizza and toppings
  2. I added a constraint for a uniqueness between pizza_id and topping_id to prevent duplicate entries in the case a malicous user wants extra pepperoni.
  3. There is a controller test for this

Deployment
   1. I tried to deploy this to heroku using sqlite but then i remembered heroku does not support sqlite so changing database was a learning experience.
   2. Tailing the production logs helped me uncover minor production friction but powered thru
   3. I used bootstrap for front end responsiveness
   4. This was a fun exercise to build from the ground up 

Additional Features to be considered

* I think it would be cool to add a realtime update of when Pizza Store Ownders added/modified a topping, an alert would go out to the Pizza Chefs. Sort of a like a notification on the nav bar i.e. Facebook notifications
* Since it was a small CRUD interface, I probably would have used View Components to DRY some of the table rendering
