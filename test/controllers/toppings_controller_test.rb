require "test_helper"

class ToppingsControllerTest < ActionDispatch::IntegrationTest
  let(:topping) { FactoryBot.create(:topping, name: "cheese") }
  let(:pizza_store_owner) { FactoryBot.create(:user, roles: [User::PIZZA_STORE_OWNER])}
  let(:pizza_chef) { FactoryBot.create(:user, roles: [User::PIZZA_CHEF])}

  describe "#index" do
    it "returns success response" do
      sign_in pizza_store_owner
      get toppings_url
      assert_response :success
    end

    context "when the current user is a pizza_chef" do
      it "get redirected" do
        sign_in pizza_chef
        get toppings_url
        assert_redirected_to pizzas_url
      end
    end
  end
  
  describe "#new" do
    it "returns success response" do
      sign_in pizza_store_owner
      get new_topping_url
      assert_response :success
    end

    context "when the current user is a pizza_chef" do
      it "get redirected" do
        sign_in pizza_chef
        get new_topping_url
        assert_redirected_to pizzas_url
      end
    end
  end

  describe "#create" do
    before { Topping.destroy_all }
    it "should create topping" do
      sign_in pizza_store_owner
      assert_difference("Topping.count") do
        post toppings_url, params: { topping: { name: "cheese" } }
      end
      assert_redirected_to topping_url(Topping.last)
    end

    context "when there is a existing topping" do
      it "does not create the topping" do
        sign_in pizza_store_owner
        topping
        assert_no_difference("Topping.count") do
          post toppings_url, params: { topping: { name: "cheese" } }
        end
      end
    end

    context "when the current user is a pizza chef" do
      it "does not create the pizza" do
        sign_in pizza_chef
        assert_no_difference("Topping.count") do
          post toppings_url, params: { topping: { name: "cheese" } }
        end
        assert_redirected_to pizzas_url
      end
    end
  end
  
  describe "#show" do
    before { Topping.destroy_all }
    it "should show topping" do
      sign_in pizza_store_owner
      get topping_url(topping)
      assert_response :success
    end

    context "when the current user is a pizza chef" do
      it "does not show the pizza" do
        sign_in pizza_chef
        get topping_url(topping)
        assert_redirected_to pizzas_url
      end
    end
  end

  describe "#edit" do
    before { Topping.destroy_all }
    it "should get edit" do
      sign_in pizza_store_owner
      get edit_topping_url(topping)
      assert_response :success
    end

    context "when the current user is a pizza chef" do
      it "should not edit" do
        sign_in pizza_chef
        get edit_topping_url(topping)
        assert_redirected_to pizzas_url
      end
    end
  end

  describe "#update" do
    before { Topping.destroy_all }
    it "should update topping" do
      sign_in pizza_store_owner
      patch topping_url(topping), params: { topping: { name: "pineapple" } }
      assert_redirected_to topping_url(topping)
      topping.reload
      assert_equal("pineapple", topping.name)
    end

    context "when the current user is a pizza chef" do
      it "does not update topping" do
        sign_in pizza_chef
        patch topping_url(topping), params: { topping: { name: "pineapple" } }
        assert_redirected_to pizzas_url
        topping.reload
        assert_equal("cheese", topping.name)
      end
    end
  end

  describe "#destroy" do
    before { Topping.destroy_all }
    it "should destroy topping" do
      sign_in pizza_store_owner
      topping
      assert_difference("Topping.count", -1) do
        delete topping_url(topping)
      end
      assert_redirected_to toppings_url
    end

    context "when a topping exist on a pizza" do
      before do
        pizza = FactoryBot.create(:pizza, name: "supreme")
        pizza.toppings << topping
        pizza.save
      end
      it "destroys the pizza_topping join record" do
        sign_in pizza_store_owner
        assert_difference("PizzaTopping.count", -1) do
          delete topping_url(topping)
        end
        assert(Pizza.last.toppings.blank?)
      end
    end

    context "when the current user is a pizza chef" do
      it "does not destroy topping" do
        sign_in pizza_chef
        topping
        assert_no_difference("Topping.count") do
          delete topping_url(topping)
        end
        assert_redirected_to pizzas_url
      end
    end
  end
end
