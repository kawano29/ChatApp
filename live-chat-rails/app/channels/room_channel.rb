class RoomChannel < ApplicationCable::Channel
  def subscribed
    if params[:room_id].present? and params[:user_uid].present?
      @user = User.find_by(uid: params[:user_uid])
      reject if @user.nil?
      @room = @user.rooms.find_by(id: params[:room_id])
      reject if @room.nil?
      stream_for(@room)
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    user = User.find_by(email: data['email'])
    room = user.rooms.find(data['roomId'])
    
    if data['message'].present?
      Message.create(content: data['message'], user_id: user.id, room_id: room.id)
    end
    RoomChannel.broadcast_to(room, message: 'ok')
  end
end
