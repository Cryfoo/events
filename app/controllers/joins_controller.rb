class JoinsController < ApplicationController
  def create
  	Join.create(user:current_user, event:Event.find(params[:event_id]))
  	redirect_to "/events"
  end

  def destroy
  	join = Join.find(params[:join_id])
  	join.destroy if join.user == current_user
  	redirect_to "/events"
  end

  private
  def current_user
  	user = User.find(session[:user_id])
  end
end
