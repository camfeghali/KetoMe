class AddColumnsToIngredientsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :carbs, :integer
    add_column :ingredients, :fiber, :integer
    add_column :ingredients, :sugar, :integer 
  end
end
