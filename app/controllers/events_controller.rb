class EventsController < ApplicationController
  load_and_authorize_resource

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index

    if params[:program_id]
        @program = Program.find(params[:program_id])
        @events = @program.events.order(start_date_time: :desc)
    else
        @events = current_user.events.order(start_date_time: :desc)
    end

    @events = event_tag_filter(@events)
    @events = event_date_filter(@events)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @details = true
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { 
          case params[:commit]
          when 'Create Event'
            redirect_to edit_event_url(@event), notice: "#{@event.name} was successfully created. " 
          when 'Create Event and View Recap'
            redirect_to @event, notice: "#{@event.name} was successfully created." 
          when 'Create Event and Add Another'
            redirect_to new_event_url, notice: "#{@event.name} was successfully created." 
          end }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { 
          case params[:commit]
          when 'Update Event'
            redirect_to edit_event_url(@event), notice: "#{@event.name} was successfully updated. " 
          when 'Update Event and View Recap'
            redirect_to @event, notice: "#{@event.name} was successfully updated." 
          when 'Update Event and Add Another'
            redirect_to new_event_url, notice: "#{@event.name} was successfully updated." 
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
      @event_decorator = EventDecorator.new(@event)
    end

    def event_date_filter(events)
      if params[:start_date].present? && params[:end_date].present?
        events.where("start_date_time >= :start_date AND start_date_time <= :end_date", 
          { start_date: Time.strptime(params[:start_date], "%m/%d/%Y"), end_date: Time.strptime(params[:end_date], "%m/%d/%Y")})
      elsif params[:start_date].present?
        events.where("start_date_time >= :start_date", 
          { start_date: Time.strptime(params[:start_date], "%m/%d/%Y")})
      elsif params[:end_date].present?
        events.where("end_date_time <= :end_date", 
          { end_date: Time.strptime(params[:end_date], "%m/%d/%Y")})
      else
        events
      end
    end

    def event_tag_filter(events)
      if params[:tag].present?
        events.tagged_with(params[:tag])
      else
        events
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name,
        :start_date_time,
        :end_date_time,
        :start_time,
        :start_date,
        :end_time,
        :end_date,
        :location_id,
        :street,
        :city,
        :state,
        :country,
        :program_id,
        :note,
        :brand_demo_fit,
        :samples_given,
        :digital_engagements,
        :mileage_impressions,
        :miles,
        :footprint_impressions,
        :walk_by_impressions,
        :total_attendance,
        :estimated_total_impressions,
        :extended_engagements,
        :weather_id,
        :tag_list,
        :cost_per_sample,
        :estimated_number_of_samples,
        :tier,
        :wholesaler_or_local_support,
        :overview,
        :kpis,
        :venue,
        :event_giveaways_attributes => [:giveaway_id, :id, :count_given_away, :event_id, :wholesaler_or_local_support, :_destroy],
        :links_attributes => [:url, :linkable_id, :linkable_type, :id, :_destroy],
        :giveaways_attributes => [:id, :name],
        :comments_attributes => [:id, :comment_id, :content, :comment_type, :_destroy],
        :weather_attributes => [:id])
    end
end
