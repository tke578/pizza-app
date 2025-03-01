class CreatePizzaToppings < ActiveRecord::Migration[8.0]
  def change
    create_table :pizza_toppings do |t|
      t.references :pizza, null: false, foreign_key: true
      t.references :topping, null: false, foreign_key: true
      t.timestamps
    end
    # Adding a unique index to prevent duplicate entries
    add_index :pizza_toppings, [:pizza_id, :topping_id], unique: true
  end
end
