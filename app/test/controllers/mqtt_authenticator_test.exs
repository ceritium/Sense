defmodule Sense.MqttAuthenticatorControllerTest do
  use Sense.ConnCase
  import Sense.Factory

  @device_valid_attrs %{ name: "Name", description: "short description" }
  @device_invalid_attrs %{ name: "", description: "" }

  test "auth users from mqtt", %{conn: conn} do
    conn = get conn, api_v1_device_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end
end
