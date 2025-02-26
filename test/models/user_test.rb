require "test_helper"

class UserTest < ActiveSupport::TestCase
  describe "#roles" do
    it "there are only 2 custom user roles" do
      user_roles = User::ROLES
      assert_equal(3, user_roles.size) # :user added by default
      assert_includes(user_roles, User::PIZZA_STORE_OWNER)
      assert_includes(user_roles, User::PIZZA_CHEF)
    end

    it "user roles cannot be additive" do
      user = create(:user, roles: [User::PIZZA_STORE_OWNER])
      user.roles << User::PIZZA_CHEF
      user.save
      user.reload
      refute(user.roles.any? { |role| role == User::PIZZA_CHEF})
    end
  end
end
