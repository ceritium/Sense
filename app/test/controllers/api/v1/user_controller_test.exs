defmodule Sense.Api.V1.UserControllerTest do
  use Sense.ConnCase
  import Sense.Factory

  setup do
    user = insert(:user, %{email: "test@sense.dev"})
    {:ok, %{user: user}}
  end

  test "[POST] Creating a user", %{conn: conn} do
    params = %{
      "user" => %{
        "email" => "john@doe.org",
        "first_name" => "some content",
        "last_name" => "some content",
        "username" => "some content",
        "password" => "password"
      }
    }
    conn = post conn, api_v1_user_path(conn, :create), params
    assert conn.status == 201
  end

  test "[POST] Creating a user with bad params", %{conn: conn} do
    params = %{
      "user" => %{
        "email" => nil,
        "first_name" => nil,
        "last_name" => "some content",
        "username" => "some content",
      }
    }
    conn = post conn, api_v1_user_path(conn, :create), params
    refute conn.status == 201
  end

  test "[POST] Creating a duplicated user return failed action", %{conn: conn} do
    params = %{
      "user" => %{
        "email" => "test@sense.dev",
        "first_name" => "some content",
        "last_name" => "some content",
        "username" => "some content",
        "password:" => "ValidPassword1"
      }
    }
    conn = post conn, api_v1_user_path(conn, :create), params
    refute conn.status == 201
  end

  test "[POST] Authenticate user with correct params", %{conn: conn} do
    params = %{
      "user" => %{
        "email": "test@sense.dev",
        "password": "ValidPassword1"
      }
    }
    conn = post conn, api_v1_user_authentication_path(conn, :authenticate), params
    assert conn.status == 200
    #    assert json_response(conn, 200) == render_json("show.json", resource: user)
  end

  test "[POST] Authenticate user with incorrect params", %{conn: conn} do
    params = %{
      "user" => %{
        "email": "test@sense.dev",
        "password": "ValidPassword2"
      }
    }
    conn = post conn, api_v1_user_authentication_path(conn, :authenticate), params
    refute conn.status == 200
    #    assert json_response(conn, 200) == render_json("show.json", resource: user)
  end

  test "[POST] Authenticate non existing user", %{conn: conn} do
    params = %{
      "user" => %{
        "email": "test2@sense.dev",
        "password": "ValidPassword1"
      }
    }
    conn = post conn, api_v1_user_authentication_path(conn, :authenticate), params
    refute conn.status == 200
    #    assert json_response(conn, 200) == render_json("show.json", resource: user)
  end
  
  #Needs authentication
  @tag :skip
  test "[GET] Show user", %{conn: conn, user: user} do
    conn = get conn, api_v1_user_path(conn, :show)
    assert conn.status == 200
    assert json_response(conn, 200) == render_json("show.json", resource: user)
  end
  
  #Needs authentication
  @tag :skip
  test "[PUT] Updating a user", %{conn: conn} do
    params = %{
      "user" => %{
        "username" => "Some username edited",
      }
    }
    conn = put conn, api_v1_user_path(conn, :update), params
    assert conn.status == 200
  end
  
  #Needs authentication
  @tag :skip
  test "[PUT] Updating a user with bad params", %{conn: conn} do
    params = %{
      "user" => %{
        "username" => nil
      }
    }
    conn = put conn, api_v1_user_path(conn, :update), params
    assert conn.status == 422
  end

  #Needs authentication
  @tag :skip
  test "[DELETE] Deleting a user", %{conn: conn} do
    conn = delete conn, api_v1_user_path(conn, :delete)
    assert conn.status == 200
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    template
    |> Sense.Api.V1.UserView.render(assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
