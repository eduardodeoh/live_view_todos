defmodule LiveViewTodosWeb.Router do
  use LiveViewTodosWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug :put_layout, {LiveViewTodosWeb.LayoutLiveView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_live do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {LiveViewTodosWeb.LayoutLiveView, :app}
  end

  scope "/", LiveViewTodosWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/counter", CounterController, :index

    get "/todos", TodosController, :index

    # scope "/todos", LiveViewTodosWeb do
    #   get "/", TodosController, :index
    # end
  end

  scope "/live", LiveViewTodosWeb do
    pipe_through :browser_live

    live("/counter", CounterLive)
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewTodosWeb do
  #   pipe_through :api
  # end
end
