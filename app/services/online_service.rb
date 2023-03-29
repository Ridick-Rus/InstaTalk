class OnlineService
  def initialize(user:)
    @user = user
  end

  def perform
    ActionCable.server.broadcast("OnlineChannel", { user: @user })
  end
end
