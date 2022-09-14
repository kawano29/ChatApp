class RoomsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show destroy]

  def index
    rooms = Room.all
    render json: rooms, status: :ok
  end

  def show
    room = Room.find_by(id: params[:room_id])
    messages = room.messages
    render json: messages, status: :ok
  end

  def create
    # byebug
    room = current_user.rooms.create(name: params[:name])
    render json: room, status: :ok
  end

  def destroy
  end
end
