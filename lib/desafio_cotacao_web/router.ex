defmodule DesafioCotacaoWeb.Router do
  use DesafioCotacaoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DesafioCotacaoWeb do
    pipe_through :api

    get "/currency_price/:currency", CurrencyPriceController, :get
  end
end
