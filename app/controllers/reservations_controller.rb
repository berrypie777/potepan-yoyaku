class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @reservations = Reservation.where(user_id: current_user.id).includes(:user)
  end

  def new
    @user = current_user
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @user = User.find_by(params[:reservation][:user_id])
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservations_path
    else
      flash[:error] = @reservation.errors.full_messages.join(", ")
      redirect_to room_path(@room)
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to reservations_path
    else
      flash[:error] = @reservation.errors.full_messages.join(", ")
      redirect_to edit_reservation_path(@reservation)
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @user = current_user
    @room = Room.find(params[:reservation][:room_id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(
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
