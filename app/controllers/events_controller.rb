class EventsController < ApplicationController
  def index
  	states
  	@user = User.find(session[:user_id])
  	@same_state_events = Event.where(state:@user.state)
  	@other_state_events = Event.where.not(state:@user.state)
  end

  def create
  	event = Event.new(event_params)
  	event.user = User.find(session[:user_id])
  	if event.valid?
  		event.save
  	else
  		flash[:errors] = event.errors.full_messages
  	end
  	redirect_to "/events"
  end

  def show
  	set_event
  end

  def edit
  	set_event
  	states
  end

  def update
  	set_event
  	@event.update(event_params)
  	if @event.valid?
  		@event.save
  		redirect_to "/events"
  	else
  		flash[:errors] = @event.errors.full_messages
	  	redirect_to "/events/edit/#{ @event.id }"
  	end
  end

  def destroy
  	set_event
  	@event.destroy if @event.user == User.find(session[:user_id])
  	redirect_to "/events"
  end

  def create_comment
  	set_event
  	comment = Comment.new(content:params[:comment], user:User.find(session[:user_id]), event:@event)
  	if comment.valid?
  		comment.save
  	else
  		flash[:errors] = comment.errors.full_messages
  	end
  	redirect_to "/events/#{ @event.id }"
  end

  private
  def event_params
  	params.require(:event).permit(:name, :date, :location, :state)
  end

  def set_event
  	@event = Event.find(params[:event_id])
  end

  def states
  	@states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
  end
end
