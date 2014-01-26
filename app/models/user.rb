class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  # Validaciones
  validates :name, :email, presence: true
  validates :name, length: { maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  # RegExp for email
  validates :email, format: { with: VALID_EMAIL_REGEX},
  									uniqueness: { case_sensitive: false }

  validates_presence_of :password, :password_confirmation
  validates_confirmation_of :password,
                          if: lambda { |m| m.password.present? }

  validates :password, length: {minimum: 6}

  before_save { self.email = email.downcase }
end
