class LocationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      @locations = Location.where("title ILIKE ?", "%#{params[:query]}%")
    else
      @locations = Location.order(created_at: :desc)
    end


  end

 # app/controllers/locations_controller.rb
def map
  if params[:address].present?
    @locations = Location.near(params[:address], params[:radius])
  else
    @locations = Location.all
  end

  @markers = @locations.geocoded.map do |location|
    {
      lat: location.latitude,
      lng: location.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { location: location })
    }
  end
end

  def show
    @location = Location.find(params[:id])
    @markers = [{
      lat: @location.latitude,
      lng: @location.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { location: @location })
    }] if @location.geocoded?
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.user = current_user

    if @location.save
      redirect_to location_path(@location)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)

    redirect_to @location
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit(:title, :address, :price, :user_id, :description)
  end
end
