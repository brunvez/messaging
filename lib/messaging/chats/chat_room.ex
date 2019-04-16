defmodule Messaging.Chats.ChatRoom do
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Chats.Message

  schema "chat_rooms" do
    field :name, :string
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(chat_room, attrs) do
    chat_room
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
