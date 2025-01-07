class AppointmentsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @location = Location.find(params[:location_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    @appointment.location = @location

    if @appointment.save
      redirect_to location_path(@location), notice: 'Réservation effectuée avec succès!'
    else
      redirect_to location_path(@location), alert: 'Cette date est déjà réservée'
    end
  end

  def edit
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :user_id, :location_id)
  end
end
