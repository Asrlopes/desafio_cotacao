defmodule DesafioCotacaoWeb.Router do
  use DesafioCotacaoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DesafioCotacaoWeb do
    pipe_through :api
  end
end
