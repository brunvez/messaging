defmodule MessagingWeb.Router do
  use MessagingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug MessagingWeb.AuthenticationPipeline
  end

  scope "/", MessagingWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api/v1", MessagingWeb.Api do
    pipe_through :api
    resources "/users", UserController, only: [:create]
    resources "/sessions", SessionController, only: [:create]
  end

  scope "/api/v1", MessagingWeb.Api do
    pipe_through [:api, :jwt_authenticated]
    resources "/user", UserController, singleton: true, only: [:show, :update]

    resources "/chat_rooms", ChatRoomController, only: [:index] do
      resources "/messages", MessageController, only: [:index, :create]
    end
  end
end
