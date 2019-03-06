class User < ApplicationRecord
  has_secure_password
  has_many :user_meals
  has_many :meals, through: :user_meals

  # validates :name, uniqueness: true

  def active_days
    self.meals.map do |meal|
      meal.created_at
    end
  end
  # def password
  #  @password
  # end

  #  pt_pw = plainttext_passwrod
  # def password=(pt_pw)
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
