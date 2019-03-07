class RenameCarbsColumnInMealsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :meals, :carbs, :net_carbs
  end
end
