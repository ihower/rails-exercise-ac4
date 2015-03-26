class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  # URL Helpers:
  #   events_path
  #   event_path(e)
  #   new_event_path
  #   edit_event_path(e)

  # GET /events
  def index
    @events = Event.page( params[:page] ).per(3)
  end

  # GET /events/123
  def show
    @title = @event.name
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events
  def create
    @event = Event.new( event_params )

    if @event.save

      flash[:notice] = "新增成功"

      redirect_to events_path
    else
      render :action => :new
    end
  end

  # GET /events/123/edit
  def edit
  end

  # PATCH /events/123
  def update
    if @event.update( event_params )

      flash[:notice] = "編輯成功"

      redirect_to events_path
    else
      render :action => :edit
    end
  end

  # DELETE /events/123
  def destroy
    @event.destroy

    flash[:alert] = "Done 刪除!!"

    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find( params[:id] )
  end

  def event_params
    params.require(:event).permit(:name, :description)
  end

end
