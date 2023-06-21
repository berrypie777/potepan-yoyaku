class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
    @user = current_user
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @q = Room.ransack
    @booking = Booking.new
    @user = current_user
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room.id)
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_own_path
  end

  def search
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
  end

  private

  def room_params
    params
      .require(:room)
      .permit(:name, :description, :price, :address, :roomimage, :room_id)
      .merge(user_id: current_user.id)
  end
end
