defmodule DesafioCotacaoWeb.CurrencyPriceController do
  use DesafioCotacaoWeb, :controller

  def get(conn, %{"currency" => currency}) do
    conn
    |> send_resp(200, currency)
  end
end
