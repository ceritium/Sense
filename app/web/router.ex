defmodule Sense.Router do
  use Sense.Web, :router

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

  scope "/", Sense do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # API Scope
  scope "/api", Sense.Api, as: :api do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/user", UserController, only: [:delete, :update, :show, :create], singleton: true
      resources "/devices", DeviceController, except: [:new, :edit] do
        resources "/metrics", MetricController, except: [:new, :edit]
      end
    end
  end
end
