defmodule Featureyard.Router do
  use Featureyard.Web, :router

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

  scope "/", Featureyard do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/clients", ClientController do
       resources "/features", FeatureController, except: [:index, :show]
    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", Featureyard do
  #   pipe_through :api
  # end
end
