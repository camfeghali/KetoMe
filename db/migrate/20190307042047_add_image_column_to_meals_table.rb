class AddImageColumnToMealsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :image_url, :string
  end
end
