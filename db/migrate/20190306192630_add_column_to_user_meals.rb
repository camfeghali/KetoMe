class AddColumnToUserMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :user_meals, :added_at, :datetime
  end
end
