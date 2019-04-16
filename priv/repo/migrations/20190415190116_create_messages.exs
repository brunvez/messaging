defmodule Messaging.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text
      add :chat_room_id, references(:chat_rooms, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:messages, [:chat_room_id])
    create index(:messages, [:user_id])
  end
end
