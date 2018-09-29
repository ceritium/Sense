defmodule Sense.Api.V1.UserController do
  use Sense.Web, :controller
  plug :scrub_params, "user" when action in ~w(authenticate)
  
  alias Sense.User
  import Sense.Factory

  def show(conn) do
    user = build(:user)
    render(conn, "show.json", resource: user)
  end

  def update(conn, %{"user" => resource_params}) do
    changeset = User.changeset(conn.assigns[:resource], resource_params)
    
    case Repo.update(changeset) do
      {:ok, resource} ->
        render(conn, "show.json", resource: resource)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Sense.ErrorView, "error.json", changeset: changeset)
    end
  end

  def delete(conn) do
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    #TODO use guardian to locate user by session
    id = 0
    Repo.delete!(conn.assigns[:resource])

    conn
    |> render("delete.json", %{id: id})
  end

  def authenticate(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Sense.Auth.user_by_email_and_pass(email, password) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("resource.json", resource: user)
      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> render(Sense.Api.V1.SessionView, "unauthorized.json")
    end
  end
  
  def create(conn, %{"user" => resource_params}) do
    changeset = User.changeset(%User{}, resource_params)

    case Repo.insert(changeset) do
      {:ok, resource} ->
        conn
        |> put_status(:created)
        |> render("show.json", resource: resource)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Sense.ErrorView, "error.json", changeset: changeset)
    end
  end  
end
