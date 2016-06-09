class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
  	@user = User.create(user_params)
  	if @user.save
		flash[:message] = "Thank you for creating a user!"
  		redirect_to '/'
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to '/users/new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to '/'
    else  
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to '/'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/'
    end
  end


  private
  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email_address, :password)
  	end
end
