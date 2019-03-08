class Meal < ApplicationRecord
  has_many :user_meals
  has_many :users, through: :user_meals

  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients


  def self.get_id(recipe_name)
    Meal.find_by(name: recipe_name).id
  end
  
  # def net_carbs_calculator
  #   carbs_calculator - fiber_calculator
  # end
  #
  # def calory_calculator
  #   calories_array.inject(0){|sum,x| sum + x }
  # end
  #
  # def fiber_calculator
  #   fiber_array.inject(0){|sum,x| sum + x }
  # end
  #
  # def sugar_calculator
  #   sugar_array.inject(0){|sum,x| sum + x }
  # end
  #
  # def carbs_calculator
  #   carbs_array.inject(0){|sum,x| sum + x }
  # end

  # def calories_array
  #   self.ingredients.map{|ingredient| ingredient.calories}
  # end
  #
  # def carbs_array
  #   self.ingredients.map{|ingredient| ingredient.carbs}
  # end
  #
  # def fiber_array
  #   self.ingredients.map{|ingredient| ingredient.fiber}
  # end
  #
  # def sugar_array
  #   self.ingredients.map{|ingredient| ingredient.sugar}
  # end


  ## -----------------CLASS METHODS------------------
  def self.search_results(search_term, meal_list)
    result = []
    meal_list.each do |meal|
      # byebug
      distance = Levenshtein.distance(search_term.downcase, meal.name.downcase)
      if distance < 6
        result << meal
      end
    end
    result
  end
end
