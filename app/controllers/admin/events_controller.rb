class Admin::EventsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  def index
    @events = Event.all
  end

  protected

  def check_admin
    unless current_user.admin?
      flash[:alert] = "Nooooooooooo!"
      redirect_to root_path
      return
    end
  end

end
