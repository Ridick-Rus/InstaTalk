class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @room = Room.find(params[:room])

    stream_from "room_channel_#{@room.id}"

    speak("message" => "* * * joined the room * * *")
  end

  def unsubscribed
    speak("message" => "* * * left the room * * *")
  end

  def receive(data)
    MessageService.new(body: data["message"], user: current_user, room: @room).perform
  end

  def speak(data)
    MessageService.new(body: data["message"], room: @room, user: current_user).perform
  end
end
