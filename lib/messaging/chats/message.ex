defmodule Messaging.Chats.Message do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias Messaging.Accounts.User
  alias Messaging.Chats.ChatRoom

  schema "messages" do
    field :content, :string
    belongs_to :user, User
    belongs_to :chat_room, ChatRoom

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
