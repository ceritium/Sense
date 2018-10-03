defmodule Sense.MqttAuthenticatorController do
  use Sense.Web, :controller

  def user(conn, params) do
    text(conn, "OK #{inspect params}")
  end

  def superuser(conn, params) do
    text(conn, "OK #{inspect params}")
  end

  def acl(conn, params) do
    text(conn, "OK #{inspect params}")
  end
end
