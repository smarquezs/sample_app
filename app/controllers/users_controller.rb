class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  # Probabdo branch prueba
  # Segundo comentario para probar branch prueba
  # Tercer comentario para probar los branches
  # Cuarta prueba de branches

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to @user, notice: 'Datos grabados correctamente'
  	else
  		render :new
  	end
  end
  
end
