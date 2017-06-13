defmodule Sense.Api.V1.UserController do
  use Sense.Web, :controller
  alias Sense.User
  
  def create(conn, %{"user" => resource_params}) do
    text conn, "Creating user with parameters #{resource_params}"
  end

  def show(conn, _) do
    text conn, "Showing user" 
  end

  def update(conn, %{"user" => resource_params}) do
    text conn, "Updating user with parameters #{resource_params}"
  end

  def delete(conn, _) do
    text conn, "Deleting user"
  end
 end
