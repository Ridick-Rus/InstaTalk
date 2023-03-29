class OnlineService
  def initialize(user:, is_online:)
    @user = user
    @is_online = is_online
  end

  def perform
    @user.update(is_online: @is_online)

    ActionCable.server.broadcast("OnlineChannel", { user: @user })
  end
end
