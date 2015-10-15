class GiveawaysController < ApplicationController
  before_action :set_giveaway, only: [:show, :edit, :update, :destroy]

  # GET /giveaways
  # GET /giveaways.json
  def index
    if params[:brand_id]
        @event = Event.find(params[:brand_id])
        @giveaways = @event.giveaways
    elsif params[:brand_id]
        @event = Event.find(params[:brand_id])
        @comments = @event.comments
    else
        @giveaways = Giveaway.order(:name)
    end
  end

  # GET /giveaways/1
  # GET /giveaways/1.json
  def show
  end

  # GET /giveaways/new
  def new
    @giveaway = Giveaway.new
  end

  # GET /giveaways/1/edit
  def edit
  end

  # POST /giveaways
  # POST /giveaways.json
  def create
    @giveaway = Giveaway.new(giveaway_params)

    respond_to do |format|
      if @giveaway.save
        format.html { redirect_to giveaways_url, notice: "#{@giveaway.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @giveaway }
      else
        format.html { render action: 'new' }
        format.json { render json: @giveaway.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /giveaways/1
  # PATCH/PUT /giveaways/1.json
  def update
    respond_to do |format|
      if @giveaway.update(giveaway_params)
        format.html { redirect_to giveaways_url, notice: "#{@giveaway.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @giveaway.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /giveaways/1
  # DELETE /giveaways/1.json
  def destroy
    @giveaway.destroy
    respond_to do |format|
      format.html { redirect_to giveaways_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_giveaway
      @giveaway = Giveaway.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def giveaway_params
      params.require(:giveaway).permit(:name,
        :image,
        :unit_cost,
        :is_a_sample,
        :starting_inventory,
        :samples_per_unit)
    end
end
