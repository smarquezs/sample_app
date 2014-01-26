class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to @user, notice: 'Datos grabados correctamente'
  	else
  		render :new
  	end
  end
  
end
