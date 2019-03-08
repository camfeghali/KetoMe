class MealsController < ApplicationController
before_action :authorized

  def api_request(search_term)
    search_term.chomp.gsub(' ', '%20')
    url = "https://api.edamam.com/search?q=#{search_term}&app_id=e4daba66&app_key=138fda9b669132a229ab76b02e149d6a&from=0&to=3&calories=591-722&health=alcohol-free"
    response = RestClient.get(url)
    hash = JSON.parse(response)["hits"]
  end


  def make_meals_and_ingredients(search_term)
    zemeals = []
    api_request(search_term).each do |recipe|
        feeds = recipe["recipe"]["yield"]
        # byebug
        zemeal = Meal.find_or_create_by(name: recipe["recipe"]["label"], meal_type: recipe["recipe"]["dietLabels"][0], image_url: recipe["recipe"]["image"], calories: recipe["recipe"]["calories"]/feeds , net_carbs: recipe["recipe"]["totalNutrients"]["CHOCDF"]["quantity"]/feeds ,fiber: recipe["recipe"]["totalNutrients"]["FIBTG"]["quantity"]/feeds ,sugar: recipe["recipe"]["totalNutrients"]["SUGAR"]["quantity"]/feeds)
        zemeals << zemeal
        recipe["recipe"]["ingredientLines"].each do |ingredient|
          ingredient = Ingredient.find_or_create_by(name: ingredient)
          MealIngredient.find_or_create_by(meal_id: zemeal.id, ingredient_id: ingredient.id)
        end
    end
    zemeals
  end

  # def make_ingredients(search_term)
  #   api_request(search_term).map do |recipe|
  #     recipe_ingredients(recipe)
  #   end
  # end

  # recipe_ingredients(recipe).each do |ingredient|
  #   ingredient = Ingredient.find_or_create_by(name: ingredient)
  #   MealIngredient.find_or_create_by(meal_id: meal.id, ingredient_id: ingredient.id)
  # end

  # def recipe_ingredients(recipe)
  #     recipe["recipe"]["ingredientLines"]
  # end

  def index
    if params[:search] == nil
     @meals = Meal.all
   elsif params[:search] == ""
     @meals = Meal.all
   elsif params[:search][0] != ""
     # meal_list = Meal.all
     # @meals = Meal.search_results(params[:search], meal_list)
     @meals = make_meals_and_ingredients(params[:search])
   else
     @meals = Meal.where(name: params[:search])
   end
  end


  def show
    @meal = Meal.find(params[:id])
    @ingredients = @meal.ingredients
  end

  def new
    @meal = Meal.new
  end

  def create
    meal = Meal.create(meal_params)
    redirect_to meals_path
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    meal = Meal.find(params[:id])
    UserMeal.create(user_id: current_user.id, meal_id: params[:id], added_at: DateTime.now.utc.in_time_zone('Eastern Time (US & Canada)'))
    redirect_to user_path(current_user.id)
  end

  def destroy
    meal = Meal.find(params[:id])
    meal.delete
    redirect_to meals_path
  end

  def self.get_id(recipe_name)
    Meal.find_by(name: recipe_name).id
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :meal_type)
  end
end
