require "application_system_test_case"

describe "Pizzas", :system do
  let(:pizza) { pizzas(:one) }

  it "visits the index" do
    visit pizzas_url
    assert_selector "h1", text: "Pizzas"
  end

  it "creates a Pizza" do
    visit pizzas_url
    click_on "New pizza"

    fill_in "Name", with: @pizza.name
    click_on "Create Pizza"

    assert_text "Pizza was successfully created"
    click_on "Back"
  end

  it "updates a Pizza" do
    visit pizza_url(@pizza)
    click_on "Edit this pizza", match: :first

    fill_in "Name", with: @pizza.name
    click_on "Update Pizza"

    assert_text "Pizza was successfully updated"
    click_on "Back"
  end

  it "destroys a Pizza" do
    visit pizza_url(@pizza)
    click_on "Destroy this pizza", match: :first

    assert_text "Pizza was successfully destroyed"
  end
end
