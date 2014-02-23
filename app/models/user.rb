class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token, :avatar, :avatar_cache
  has_secure_password

  mount_uploader :avatar, AvatarUploader

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

  # LLama al metodo privado create_remember_token
  before_create :create_remember_token

  # Genera un token aleatorio usando urlsafe_base64 de SecureRandom
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # Se encripta el token usando SHA1
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    # Método privado que de retorna el atributo remember_token para ser guardado en la base de datos
    # antes de llamar al metodo create
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
