defmodule MessagingWeb.Api.ChatRoomView do
  use MessagingWeb, :view

  def render("index.json", %{chat_rooms: chat_rooms}) do
    %{data: render_many(chat_rooms, __MODULE__, "chat_room.json")}
  end

  def render("chat_room.json", %{chat_room: chat_room}) do
    %{
      id: chat_room.id,
      name: chat_room.name
    }
  end
end
