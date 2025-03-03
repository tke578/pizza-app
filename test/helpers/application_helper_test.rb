require "test_helper"


class ApplicationHelperTest < ActionView::TestCase
  describe "#root_path_for_user" do
    context "if the current_user is pizza_chef" do
      before { @current_user = FactoryBot.build(:user, roles: [User::PIZZA_CHEF])}
      it "returns the pizzas url" do
        assert_match(/pizza/, root_path_for_user)
      end
    end

    context "if the current_user is the pizza_store_owner" do
      before { @current_user = FactoryBot.build(:user, roles: [User::PIZZA_STORE_OWNER])}
      it "returns the toppings url" do
        assert_match(/topping/, root_path_for_user)
      end
    end
  end

  def current_user
    @current_user
  end
end