class EventsController < ApplicationController

	before_filter :self_load, :only=>[:show, :edit, :update, :destroy]
	
	before_filter :require_login, :only=>[:edit, :update, :destroy]

  def index
    @events = Event.all    
  end

  def show
    @comment = @event.comments.build
		@comments = @event.comments
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.' 
    else
      render action: "new"
    end
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url 
  end

private

	def self_load
		@event = Event.find(params[:id])
	end

	def require_login
		redirect_to sign_in_path, notice: 'Please Log in' if !current_user			
	end

end
