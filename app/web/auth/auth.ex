defmodule Sense.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  alias Sense.User
  alias Sense.Repo

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def user_by_email_and_pass(email, given_pass) do
    user = Repo.get_by(User, email: email)
    cond do
      user && checkpw(given_pass, user.encrypted_password) ->
        {:ok, user}
      user ->
        {:error, :unauthorized}
      true ->
        dummy_checkpw()
        {:error, :not_found}
    end
  end

  def login_by_email_and_pass(conn, email, given_pass) do
    case user_by_email_and_pass(conn, email, given_pass) do
      {:ok, user}
        {:ok, login(conn, user)}
      {:error, error_type}
        {:error, error_type}
    end
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end
end
