class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    if params[:program_id]
        @program = Program.find(params[:program_id])
        @events = @program.events.order(start_date_time: :desc)
    else
        @events = Event.all.order(start_date_time: :desc)
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
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
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
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name,
        :start_date_time,
        :end_date_time,
        :location_id,
        :program_id,
        :note,
        :brand_demo_fit,
        :samples_given,
        :digital_engagements,
        :mileage_impressions,
        :footpring_attendance,
        :display_attendance,
        :total_attendance,
        :estimated_total_impressions,
        :weather_id,
        :wholesaler_or_local_support,
        :event_giveaways_attributes => [:giveaway_id, :id, :count_given_away, :event_id],
        :giveaways_attributes => [:id, :name],
        :weather_attributes => [:id],
        :location_attributes => [:id, :name])
    end
end
