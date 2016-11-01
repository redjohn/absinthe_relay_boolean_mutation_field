defmodule BooleanFields.Router do
  use BooleanFields.Web, :router

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

  pipeline :graphql do
    plug GraphqlLogger
  end

  scope "/", BooleanFields do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  if Mix.env == :dev do
    pipe_through :graphql
    forward "/docs", Absinthe.Plug.GraphiQL, schema: BooleanFields.Schema
  end
end
