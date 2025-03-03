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

Additional Features to be considered

* I think it would be cool to add a realtime update of when Pizza Store Ownders added/modified a topping, an alert would go out to the Pizza Chefs. Sort of a like a notification on the nav bar i.e. Facebook notifications
* Since it was a small CRUD interface, I probably would have used View Components to DRY some of the table rendering
