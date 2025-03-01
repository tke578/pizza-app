class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.pizza_store_owner?
      toppings_path
    elsif resource.pizza_chef?
      pizzas_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
