class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: Settings.validates.maximum_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.validates.maximum_email},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.validates.minimum_password}
  before_save{email.downcase!}
  has_secure_password
end
