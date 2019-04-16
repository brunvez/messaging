defmodule Messaging.Accounts.Guardian do
  @moduledoc """
    Module in charge of creating and validating
    tokens for authentication
  """
  use Guardian, otp_app: :messaging

  alias Messaging.Accounts

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Accounts.get_user!(id)
    {:ok, resource}
  end
end
