class MessagesController < ApplicationController
  before_action :authenticate_user!, only: %i[index destroy]

  def index
    room = Room.find(params[:room_id])
    messages = room.messages.includes(:user, [likes: :user])
    messages_array = messages.map do |message|
      {
        id: message.id,
        user_id: message.user.id,
        name: message.user.name,
        content: message.content,
        email: message.user.email,
        created_at: message.created_at,
        likes: message.likes.map { |like| { id: like.id, email: like.user.email }  }
      }
    end

    render json: messages_array, status: :ok
  end

  def destroy
    message = Message.find(params[:id])

    if message.destroy
      render json: { id: message.id, email: message.user.email, message: '削除に成功しました' }, status: :ok
    else
      render json: { message: '削除できませんでした', errors: like.errors.messages }, status: :bad_request
    end
  end
end
