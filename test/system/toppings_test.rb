require "application_system_test_case"

describe "Toppings", :system do
  let(:topping) { toppings(:one) }

  it "visits the index" do
    visit toppings_url
    assert_selector "h1", text: "Toppings"
  end

  it "creates a Topping" do
    visit toppings_url
    click_on "New topping"

    fill_in "Name", with: @topping.name
    click_on "Create Topping"

    assert_text "Topping was successfully created"
    click_on "Back"
  end

  it "updates a Topping" do
    visit topping_url(@topping)
    click_on "Edit this topping", match: :first

    fill_in "Name", with: @topping.name
    click_on "Update Topping"

    assert_text "Topping was successfully updated"
    click_on "Back"
  end

  it "destroys a Topping" do
    visit topping_url(@topping)
    click_on "Destroy this topping", match: :first

    assert_text "Topping was successfully destroyed"
  end
end
