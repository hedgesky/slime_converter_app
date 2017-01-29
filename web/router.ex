defmodule SlimeConverter.Router do
  use SlimeConverter.Web, :router

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

  scope "/", SlimeConverter do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", SlimeConverter do
    pipe_through :api

    post "/slime2html", ApiController, :slime2html
  end
end
