module ApplicationHelper
  def root_path_for_user
    if current_user.has_role?(User::PIZZA_CHEF)
      link_to "Pizzas", pizzas_url, class: "nav-link" 
    elsif current_user.has_role?(User::PIZZA_STORE_OWNER)
      link_to "Toppings", toppings_url, class: "nav-link"
    end
  end
end
