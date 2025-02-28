require "test_helper"

describe Topping < ActiveSupport::TestCase do
  describe "#validations" do
    before { Topping.destroy_all }
    it "has a valid topping name" do
      topping = FactoryBot.build(:topping, name: "cheese")
      assert(topping.valid?)
    end

    context "when there is a topping with a existing name(case sensistive)" do
      before do
        FactoryBot.create(:topping, name: "cheese")
      end
      it "should not be valid" do
        topping = FactoryBot.build(:topping, name: "Cheese")
        refute(topping.valid?)
        assert_equal("Name has already been taken", topping.errors.full_messages.first)
      end
    end
  end
end
