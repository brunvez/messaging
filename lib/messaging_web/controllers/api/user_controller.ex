defmodule MessagingWeb.Api.UserController do
  use MessagingWeb, :controller

  alias Messaging.Accounts
  alias Messaging.Accounts.User

  action_fallback MessagingWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token} <- Accounts.generate_token(user) do
      conn |> put_status(201) |> render("token.json", token: token)
    end
  end

  def show(conn, _params) do
    render(conn, "show.json", user: current_user(conn))
  end

  def update(conn, %{"user" => user_params}) do
    user = current_user(conn)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  defp current_user(conn) do
    conn.assigns.current_user
  end
end
