class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    
  end
  def create
  	@user = User.new(params[:user])
  	if @user.save
      # Se logea automáticamente el usuario al rgistrarse, luego es dirigido al perfil del usuario
      sign_in @user
      redirect_to @user, notice: 'Welcome to the Sample App!'
  	else
  		render 'new'
  	end
  end
  
end
