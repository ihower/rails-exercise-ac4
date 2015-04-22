class EventsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_event, :only => [:show, :edit, :update, :destroy, :dashboard]

  # URL Helpers:
  #   events_path
  #   event_path(e)
  #   new_event_path
  #   edit_event_path(e)

  # GET /events
  def index

    load_events

    @event = Event.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end
  end

  def latest
    @events = Event.order("id DESC").limit(3)
  end

  def popular
  end

  # GET /events/123
  def show
    @title = @event.name
  end

  def dashboard
  end

  # POST /events
  def create
    @event = Event.new( event_params )

    @event.user = current_user

    if @event.save

      flash[:notice] = I18n.t("create_successful")

      redirect_to events_path
    else
      load_events
      render :action => :index
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

  def bulk_update
    events = params[:ids].map{ |x| Event.find(x) }

    events.each do |x|
      if params["btn-delete"]
        x.destroy
      elsif params["btn-publish"]
        x.update( :status => "published" )
      end
    end

    redirect_to events_url
  end

  def bulk_delete
    #Event.destroy_all
    Event.first.destroy

    flash[:alert] = "砍了!"
    redirect_to events_url
  end

  private

  def load_events
    if params[:category_id]
      @category = Category.find( params[:category_id] )
      @events = @category.events.page( params[:page] ).per(3)
    else
      @events = Event.page( params[:page] ).per(3)
    end

    if params[:order] == "created_at_desc"
      @events = @events.order("created_at DESC")
    end

    if params[:keyword]
      @events = @events.where( [ "name like ?", "%#{params[:keyword]}%" ] )
    end

    @categories = Category.all
  end

  def set_event
    @event = Event.find( params[:id] )
  end

  def event_params
    params.require(:event).permit(:name, :tag_list, :_destory_logo, :description, :status, :published_at, :due_date, :category_id, :logo, :detail_attributes => [:information, :_destroy, :id], :group_ids => [] )
  end

end
