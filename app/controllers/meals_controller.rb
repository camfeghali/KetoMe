class MealsController < ApplicationController

  def api_request(search_term)
    search_term.chomp.gsub(' ', '%20')
    url = "https://api.edamam.com/search?q=#{search_term}&app_id=e4daba66&app_key=138fda9b669132a229ab76b02e149d6a&from=0&to=3&calories=591-722&health=alcohol-free"
    response = RestClient.get(url)
    hash = JSON.parse(response)["hits"]
  end


  def recipe_names(search_term)
    api_request(search_term).map do |recipe|
       Meal.find_or_create_by(name: recipe["recipe"]["label"])
       # byebug
    end
    # byebug
  end

  def index
    if params[:search] == nil
     @meals = Meal.all
   elsif params[:search] == ""
     @meals = Meal.all
   elsif params[:search][0] != ""
     # meal_list = Meal.all
     # @meals = Meal.search_results(params[:search], meal_list)
     # byebug
     @meals = recipe_names(params[:search])
     # byebug
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

  private

  def meal_params
    params.require(:meal).permit(:name, :meal_type)
  end
end
