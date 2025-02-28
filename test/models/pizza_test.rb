require "test_helper"

describe Pizza < ActiveSupport::TestCase do
  describe "#validations" do
    before { Pizza.destroy_all }
    it "has a valid pizza name" do
      pizza = FactoryBot.build(:pizza, name: "Supreme")
      assert(pizza.valid?)
    end

    context "when there is a pizza with a existing name(case sensistive)" do
      before do
        FactoryBot.create(:pizza, name: "supreme")
      end
      it "should not be valid" do
        pizza = FactoryBot.build(:pizza, name: "Supreme")
        refute(pizza.valid?)
        assert_equal("Name has already been taken", pizza.errors.full_messages.first)
      end
    end
  end
end
