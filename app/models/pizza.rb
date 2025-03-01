class Pizza < ApplicationRecord
  has_many :pizza_toppings
  has_many :toppings, -> { distinct }, through: :pizza_toppings

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
