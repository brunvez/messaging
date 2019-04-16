defmodule MessagingWeb.Api.MessageController do
  use MessagingWeb, :controller

  alias Messaging.Chats

  action_fallback MessagingWeb.FallbackController

  def index(conn, %{"chat_room_id" => chat_room_id}) do
    chat_room = Chats.get_chat_room!(chat_room_id)
    render(conn, "index.json", messages: Chats.list_messages(chat_room))
  end

  def create(conn, %{"message" => message_params, "chat_room_id" => chat_room_id}) do
    chat_room = Chats.get_chat_room!(chat_room_id)
    with {:ok, message} <- Chats.create_message(message_params, chat_room, current_user(conn)) do
      conn |> put_status(201) |> render("show.json", message: message)
    end
  end

  defp current_user(conn) do
    conn.assigns.current_user
  end
end
