module SessionsHelper
	# Se guarda la cookie
	def sign_in(user)
		# Se crea un remember_token (aleatorio)
		remember_token = User.new_remember_token
		# se crea la cookie como permanente
		cookies.permanent[:remember_token] = remember_token
		# Se actualiza el campo remember_token en tabla users
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		# Se setea current user al nuevo usuario
		self.current_user = user
	end


	# Setter current user
	def current_user=(user)
		@current_user = user
	end

	# getter current_user
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by_remember_token(remember_token)
	end

	# Verifica si el usuario está o no logeado
	def signed_in?
    !current_user.nil?
  end

  def sign_out
  	#Se actualiza el remember_token
  	current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
  	# Se elimina la cookie
  	cookies.delete(:remember_token)
  	# Se deja como nil el current user
  	self.current_user = nil
  end
end
