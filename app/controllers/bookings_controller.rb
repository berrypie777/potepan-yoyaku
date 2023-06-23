class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @bookings = Booking.where(user_id: current_user.id).includes(:user)
  end

  def new
    @user = current_user
    @room = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def create
    @user = User.find_by(params[:booking][:user_id])
    @room = Room.find(params[:booking][:room_id])
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to bookings_path
    else
      flash[:error] = @booking.errors.full_messages.join(", ")
      redirect_to room_path(@room)
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to bookings_path
    else
      flash[:error] = @booking.errors.full_messages.join(", ")
      redirect_to edit_booking_path(@booking)
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  def confirm
    @booking = Booking.new(booking_params)
    @user = current_user
    @room = Room.find(params[:booking][:room_id])
  end

  private

  def booking_params
    params.require(:booking).permit(
      :checkin_date,
      :checkout_date,
      :guest,
      :total_price,
      :total_date,
      :room_id,
      :user_id
    )
  end
end
