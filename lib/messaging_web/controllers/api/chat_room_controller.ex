defmodule MessagingWeb.Api.ChatRoomController do
  use MessagingWeb, :controller

  alias Messaging.Chats

  action_fallback MessagingWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", chat_rooms: Chats.list_chat_rooms)
  end
end
