class EventDetailsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_event

  def show
    @detail = @event.detail
  end

  def new
    @detail = @event.build_detail
  end

  def create
    @detail = @event.build_detail( detail_params )

    if @detail.save
      redirect_to event_detail_path(@event)
    else
      render :new
    end
  end

  def edit
    @detail = @event.detail
  end

  def update
    @detail = @event.detail

    if @detail.update( detail_params )
      redirect_to event_detail_path(@event)
    else
      render :edit
    end

  end

  def destroy
    @event.detail.destroy

    redirect_to event_detail_path(@event)
  end

  protected

  def detail_params
    params.require(:event_detail).permit(:information)
  end

end
