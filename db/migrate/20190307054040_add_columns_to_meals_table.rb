class AddColumnsToMealsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :calories, :integer
    add_column :meals, :carbs, :integer
    add_column :meals, :sugar, :integer
    add_column :meals, :fiber, :integer
  end
end
