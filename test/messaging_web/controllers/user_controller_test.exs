defmodule MessagingWeb.UserControllerTest do
  use MessagingWeb.ConnCase

  alias Messaging.Accounts
  alias Messaging.Accounts.User

  @create_attrs %{
    email: "some@email",
    password: "some password",
    password_confirmation: "some password"
  }
  @update_attrs %{
    email: "updated@email",
    password: "some updated password",
    password_confirmation: "some updated password"
  }
  @invalid_attrs %{email: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"token" => token} = json_response(conn, 201)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user, :authenticate_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id}} do
      conn = put(conn, Routes.user_path(conn, :update), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show))

      assert %{
               "id" => id,
               "email" => "updated@email",
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = put(conn, Routes.user_path(conn, :update), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

  defp authenticate_user(%{conn: conn, user: user}) do
    {:ok, token} = Accounts.generate_token(user)
    conn = put_req_header(conn, "authorization", "bearer: " <> token)
    {:ok, conn: conn}
  end
end
