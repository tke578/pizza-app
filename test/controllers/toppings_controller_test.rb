require "test_helper"

describe ToppingsController do
  let(:topping) { toppings(:one) }

  it "should get index" do
    get toppings_url
    must_respond_with :success
  end

  it "should get new" do
    get new_topping_url
    must_respond_with :success
  end

  it "should create topping" do
    assert_difference("Topping.count") do
      post toppings_url, params: { topping: { name: @topping.name } }
    end

    must_redirect_to topping_url(Topping.last)
  end

  it "should show topping" do
    get topping_url(@topping)
    must_respond_with :success
  end

  it "should get edit" do
    get edit_topping_url(@topping)
    must_respond_with :success
  end

  it "should update topping" do
    patch topping_url(@topping), params: { topping: { name: @topping.name } }
    must_redirect_to topping_url(@topping)
  end

  it "should destroy topping" do
    assert_difference("Topping.count", -1) do
      delete topping_url(@topping)
    end

    must_redirect_to toppings_url
  end
end
