class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def new
    @pet = Pet.find(params[:pet_id])
    @booking = Booking.new
    authorize @booking
  end

  def edit
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def create
  end

  def index
    @bookings = policy_scope(Booking)
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.update(params.require(:booking).permit(:start_date, :end_date))
      redirect_to pet_path(@pet) # ALTERAR ISTO????
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path(@booking)
    authorize @booking
  end

  private

  def pet_params
    params.require(:booking).permit([:start_date, :end_date])
  end
end
