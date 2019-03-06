class Ingredient < ApplicationRecord
  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients

  def net_carbs
    self.carbs - self.fiber
  end

  def self.search_results(search_term, ingredient_list)
    result = []
    ingredient_list.each do |ingredient|
      # byebug
      distance = Levenshtein.distance(search_term.downcase, ingredient.name.downcase)
      if distance < 6
        result << ingredient
      end
    end
    result
  end
end
