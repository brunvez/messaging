defmodule MessagingWeb.Api.SessionView do
  use MessagingWeb, :view

  def render("token.json", %{token: jwt}) do
    %{token: jwt}
  end
end
