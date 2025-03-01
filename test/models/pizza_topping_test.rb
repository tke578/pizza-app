require "test_helper"

class PizzaToppingTest < ActiveSupport::TestCase
  describe "#associations" do
    it "belongs_to toppings" do
      assert_belongs_to PizzaTopping, :topping
    end

    it "belongs_to pizzas" do
      assert_belongs_to PizzaTopping, :pizza
    end
  end
end