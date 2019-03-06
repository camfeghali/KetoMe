class User < ApplicationRecord
  has_secure_password
  has_many :user_meals
  has_many :meals, through: :user_meals

  validates_uniqueness_of :name, message: 'Username taken!'

  # def active_days
  #   self.meals.map do |meal|
  #     meal.created_at
  #   end
  # end

  def this_day_net_carbs(day)

    this_day_meals(day).map do |meal|
      meal.net_carbs_calculator
    end.inject(0){|sum,x| sum + x }
  end

  def this_day_meals_name(day)
    this_day_meals(day).map{|meal| meal.name}
  end

  def this_day_meals(day)
    this_day_user_meals(day).map do |user_meal|
      user_meal.meal
    end
  end

  def this_day_user_meals(day)
    self.user_meals.select do |user_meal|
      # byebug
      user_meal.added_at.to_s[0..9] == day.to_s
    end
  end

  def todays_carbs
    carbs_array.inject(0){|sum,x| sum + x }
  end

  def carbs_array
    self.meals.map do |meal|
      meal.net_carbs_calculator
    end
  end
  # def password
  #  @password
  # end

  #  pt_pw = plainttext_passwrod
  #   self.password_digest = BCrypt::Password.create(pt_pw)
  # end

  # def authenticate(pt_pw) # 'goat'
  # compare an already existing user's plaintext_pw against the salted and hashed version we have in the db
  #    if BCrypt::Password.new(self.password_digest) == pt_pw
  #      return true
  #    else
  #      false
  #
  #    end
  # end
end
