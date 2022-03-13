class Admin < ApplicationRecord
  belongs_to :user, dependent: :destroy

  # attr_accessor :email, :password, :password_confirmation, :remember_me
  # attr_accessor :email
  
  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   email = conditions.delete(:email)
  #   where(conditions).where(["lower(email) = :value", { :value => email.strip.downcase }]).first
  # end
end
