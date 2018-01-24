defmodule TriangleFarmsWeb.Router do
  use TriangleFarmsWeb, :router

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

  scope "/", TriangleFarmsWeb do
    pipe_through :browser
    get "/", PageController, :index
    get "/reset", EventController, :reset
  end

  scope "/api", TriangleFarmsWeb do
    pipe_through :api
    get "/events", EventController, :index
  end
end
