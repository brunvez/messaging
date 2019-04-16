defmodule MessagingWeb.Api.SessionController do
  use MessagingWeb, :controller

  alias Messaging.Accounts

  action_fallback MessagingWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token} ->
        conn
        |> put_resp_header("Authorization", token)
        |> send_resp(201, "")
      _ ->
        {:error, :unauthorized}
    end
  end
end
