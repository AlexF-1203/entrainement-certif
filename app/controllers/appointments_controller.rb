class AppointmentsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @location = Location.find(params[:location_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.location = @location
    @appointment.user = current_user

    if @appointment.save
      redirect_to location_path(@location), notice: 'Appointment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :user_id, :location_id)
  end
end
