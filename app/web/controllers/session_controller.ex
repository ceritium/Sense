defmodule Sense.SessionController do
  use Sense.Web, :controller
  plug :scrub_params, "session" when action in ~w(create)a

  def create(conn, %{"session" => %{"email" => email,
                                    "password" => password}}) do
  
    case Sense.Auth.login_by_email_and_pass(conn, email,
          password) do
      {:ok, conn, user: user} ->
        conn
        |> render("user.json", user: user)
      {:error, _reason, conn} ->
        conn
        |> render("error.json", message: "Invalid credentials")
    end
  end

  def delete(conn, _) do
    conn
    |> Sense.Auth.logout
    |> render("delete.json")
  end
end
