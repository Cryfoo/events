class LoginsController < ApplicationController
  def main
  	states
  end

  def create
  	user = User.create(user_params)
  	if user.valid?
  		session[:user_id] = user.id
  		redirect_to "/events"
  	else
  		flash[:errors] = user.errors.full_messages
  		redirect_to "/"
  	end
  end

  def login
  	user = User.find_by(email:params[:email])
  	flash[:errors] = []
  	if params[:email] == ''
  		flash[:errors] << "Email cannot be blank"
  	end
  	if params[:password] == ''
  		flash[:errors] << "Password cannot be blank"
  	end
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to "/events"
  	else
  		flash[:errors] << "Invalid Login"
  		redirect_to "/"
  	end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to "/"
  end

  def show
  	set_user
  	states
  end

  def update
  	set_user
  	@user.update(user_params)
  	if @user.valid?
  		@user.save
  		redirect_to "/events"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to "/user/#{ @user.id }"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
  end

  def set_user
  	@user = User.find(params[:id])
  end

  def states
  	@states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
  end
end
