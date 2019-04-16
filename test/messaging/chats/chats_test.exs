defmodule Messaging.ChatsTest do
  use Messaging.DataCase

  alias Messaging.Accounts
  alias Messaging.Chats

  describe "chat_rooms" do
    alias Messaging.Chats.ChatRoom

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def chat_room_fixture(attrs \\ %{}) do
      {:ok, chat_room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chats.create_chat_room()

      chat_room
    end

    test "list_chat_rooms/0 returns all chat_rooms" do
      chat_room = chat_room_fixture()
      assert Chats.list_chat_rooms() == [chat_room]
    end

    test "get_chat_room!/1 returns the chat_room with given id" do
      chat_room = chat_room_fixture()
      assert Chats.get_chat_room!(chat_room.id) == chat_room
    end

    test "create_chat_room/1 with valid data creates a chat_room" do
      assert {:ok, %ChatRoom{} = chat_room} = Chats.create_chat_room(@valid_attrs)
      assert chat_room.name == "some name"
    end

    test "create_chat_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_chat_room(@invalid_attrs)
    end

    test "update_chat_room/2 with valid data updates the chat_room" do
      chat_room = chat_room_fixture()
      assert {:ok, %ChatRoom{} = chat_room} = Chats.update_chat_room(chat_room, @update_attrs)
      assert chat_room.name == "some updated name"
    end

    test "update_chat_room/2 with invalid data returns error changeset" do
      chat_room = chat_room_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_chat_room(chat_room, @invalid_attrs)
      assert chat_room == Chats.get_chat_room!(chat_room.id)
    end

    test "delete_chat_room/1 deletes the chat_room" do
      chat_room = chat_room_fixture()
      assert {:ok, %ChatRoom{}} = Chats.delete_chat_room(chat_room)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_chat_room!(chat_room.id) end
    end
  end

  describe "messages" do
    alias Messaging.Chats.Message

    @valid_attrs %{content: "some content"}
    @invalid_attrs %{content: nil}

    def message_fixture(attrs \\ %{}) do
      chat_room = chat_room_fixture()
      user = user_fixture()
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chats.create_message(chat_room, user)

      message
    end

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(%{
          email: "some@email",
          password: "some password",
          password_confirmation: "some password"
        })
        |> Accounts.create_user()

      user
    end

    test "list_messages/1 returns all messages" do
      message = message_fixture()
      assert Enum.count(Chats.list_messages(message.chat_room)) == 1
    end

    test "create_message/3 with valid data creates a message" do
      chat_room = chat_room_fixture()
      user = user_fixture()
      assert {:ok, %Message{} = message} = Chats.create_message(@valid_attrs, chat_room, user)
      assert message.content == "some content"
    end

    test "create_message/3 with invalid data returns error changeset" do
      chat_room = chat_room_fixture()
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.create_message(@invalid_attrs, chat_room, user)
    end
  end
end
