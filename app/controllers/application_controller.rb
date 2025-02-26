class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.pizza_store_owner?
      home_index_path
    elsif resource.pizza_chef?
      home_index_path
    end
  end
end
