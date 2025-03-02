require "test_helper"

require "test_helper"

class PizzasControllerTest < ActionDispatch::IntegrationTest
  let(:pizza) { FactoryBot.create(:pizza, name: "supreme") }
  let(:pizza_store_owner) { FactoryBot.create(:user, roles: [User::PIZZA_STORE_OWNER])}
  let(:pizza_chef) { FactoryBot.create(:user, roles: [User::PIZZA_CHEF])}

  describe "#index" do
    it "returns success response" do
      sign_in pizza_chef
      get pizzas_url
      assert_response :success
    end

    context "when the current user is a pizza_store_owner" do
      it "get redirected" do
        sign_in pizza_store_owner
        get pizzas_url
        assert_redirected_to toppings_url
      end
    end
  end
  
  describe "#new" do
    it "returns success response" do
      sign_in pizza_chef
      get new_pizza_url
      assert_response :success
    end

    context "when the current user is a pizza_store_owner" do
      it "get redirected" do
        sign_in pizza_store_owner
        get new_pizza_url
        assert_redirected_to toppings_url
      end
    end
  end

  describe "#create" do
    before { Pizza.destroy_all }
    it "should create pizza" do
      sign_in pizza_chef
      assert_difference("Pizza.count") do
        post pizzas_url, params: { pizza: { name: "pizza" } }
      end
      assert_redirected_to pizza_url(Pizza.last)
    end

    context "when there is a existing pizza" do
      before { FactoryBot.create(:topping, name: "cheese")}
      it "does not create the pizza" do
        sign_in pizza_chef
        pizza
        assert_no_difference("Pizza.count") do
          assert_no_difference("PizzaTopping.count") do
            post toppings_url, params: { pizza: { name: "pizza", topping_ids: [Topping.last.id] } }
          end
        end
      end
    end

    context "when the current user is a pizza_store_owner" do
      it "does not create the pizza" do
        sign_in pizza_store_owner
        assert_no_difference("Pizza.count") do
          post pizzas_url, params: { pizza: { name: "supreme" } }
        end
        assert_redirected_to toppings_url
      end
    end

    context "when toppings exists" do
      before { FactoryBot.create(:topping, name: "cheese")}
      it "creates the pizza topping" do
        sign_in pizza_chef
        assert_difference ["Pizza.count", "PizzaTopping.count"], 1 do
          post pizzas_url, params: { pizza: { name: "supreme", topping_ids: [Topping.last.id] } }
        end
        toppings = Pizza.last.toppings
        assert_equal(1, Pizza.last.toppings.size)
        assert_equal("cheese", toppings.first.name)
      end

      context "if a user tries to malicously add a duplicate topping" do
        it "only creates one pizza topping" do
          sign_in pizza_chef
          assert_difference("Pizza.count") do
            assert_difference ["PizzaTopping.count"], 1 do
              post pizzas_url, params: { pizza: { name: "supreme", topping_ids: [Topping.last.id, Topping.last.id] } }
            end
          end
          toppings = Pizza.last.toppings
          assert_equal(1, Pizza.last.toppings.size)
          assert_equal("cheese", toppings.first.name)
        end
      end
    end
  end
  
  describe "#show" do
    before { Pizza.destroy_all }
    it "should show pizza" do
      sign_in pizza_chef
      get pizza_url(pizza)
      assert_response :success
    end

    context "when the current user is a pizza_store_owner`" do
      it "does not show the pizza" do
        sign_in pizza_store_owner
        get pizza_url(pizza)
        assert_redirected_to toppings_url
      end
    end
  end

  describe "#edit" do
    before { Pizza.destroy_all }
    it "should get edit" do
      sign_in pizza_chef
      get edit_pizza_url(pizza)
      assert_response :success
    end

    context "when the current user is a pizza chef" do
      it "should not edit" do
        sign_in pizza_store_owner
        get edit_pizza_url(pizza)
        assert_redirected_to toppings_url
      end
    end
  end

  describe "#update" do
    before { Pizza.destroy_all }
    it "should update pizza" do
      sign_in pizza_chef
      patch pizza_url(pizza), params: { pizza: { name: "supreme" } }
      assert_redirected_to pizza_url(pizza)
      pizza.reload
      assert_equal("supreme", pizza.name)
    end

    context "when the current user is a pizza_store_owner" do
      it "does not update pizza" do
        sign_in pizza_store_owner
        patch pizza_url(pizza), params: { pizza: { name: "supreme" } }
        assert_redirected_to toppings_url
        pizza.reload
        assert_equal("supreme", pizza.name)
      end
    end

    context "when a pizza topping exists" do
      before do
        pizza.toppings << FactoryBot.create(:topping, name: "cheese")
        pizza.save
        FactoryBot.create(:topping, name: "pineapple" )
      end
      context "change the topping" do
        it "should change the pizza topping" do
          sign_in pizza_chef
          patch pizza_url(pizza), params: { pizza: { name: "supreme", topping_ids: [Topping.last.id] } }
          pizza_toppings = pizza.toppings
          assert_equal(1, pizza_toppings.size)
          assert(pizza_toppings.include? Topping.last)
        end
      end
      context "if a user tries to malicously add a duplicate topping" do
        it "only creates one pizza topping" do
          sign_in pizza_chef
          patch pizzas_url, params: { pizza: { name: "supreme", topping_ids: [Topping.last.id, Topping.last.id] } }
          toppings = Pizza.last.toppings
          assert_equal(1, Pizza.last.toppings.size)
          assert_equal("cheese", toppings.first.name)
        end
      end
    end
  end

  describe "#destroy" do
    before { Pizza.destroy_all }
    it "should destroy pizza" do
      sign_in pizza_chef
      pizza
      assert_difference("Pizza.count", -1) do
        delete pizza_url(pizza)
      end
      assert_redirected_to pizzas_url
    end

    context "when the current user is a pizza_store_owner" do
      it "does not destroy pizza" do
        sign_in pizza_store_owner
        pizza
        assert_no_difference("Pizza.count") do
          delete pizza_url(pizza)
        end
        assert_redirected_to toppings_url
      end
    end

    context "when a pizza has a topping" do
      before do
        pizza.toppings << FactoryBot.create(:topping, name: "cheese")
        pizza.save
      end
      it "destroy the pizza_topping record" do
        sign_in pizza_chef
        assert_difference ["Pizza.count", "PizzaTopping.count"], -1 do
          delete pizza_url(pizza)
        end
        assert_redirected_to pizzas_url
      end
    end
  end
end
