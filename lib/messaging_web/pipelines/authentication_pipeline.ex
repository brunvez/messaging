defmodule MessagingWeb.AuthenticationPipeline do
  @moduledoc """
  Authenticates the user based on the token found in
  the Authentication header
  """
  use Guardian.Plug.Pipeline,
    otp_app: :messaging,
    module: Messaging.Accounts.Guardian,
    error_handler: MessagingWeb.Authentication.ErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug MessagingWeb.Authentication.SetCurrentUser
end
