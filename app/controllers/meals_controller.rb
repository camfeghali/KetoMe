class MealsController < ApplicationController
  def index
    if params[:search] == nil
     @meals = Meal.all
   elsif params[:search] == ""
     @meals = Meal.all
   elsif params[:search][0] != ""
     meal_list = Meal.all
     @meals = Meal.search_results(params[:search], meal_list)
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
    meal.update(meal_params)
    redirect_to user_path(meal)
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
