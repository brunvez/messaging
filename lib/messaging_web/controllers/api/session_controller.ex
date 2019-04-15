defmodule MessagingWeb.Api.SessionController do
  use MessagingWeb, :controller

  alias Messaging.Accounts

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token} ->
        conn |> render("token.json", token: token)
      _ ->
        {:error, :unauthorized}
    end
  end
end
