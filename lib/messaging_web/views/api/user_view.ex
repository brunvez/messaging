defmodule MessagingWeb.Api.UserView do
  use MessagingWeb, :view
  alias MessagingWeb.Api.SessionView
  alias MessagingWeb.Api.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email
    }
  end

  def render("token.json", token) do
    SessionView.render("token.json", token)
  end
end
