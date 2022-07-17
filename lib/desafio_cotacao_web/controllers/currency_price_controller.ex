defmodule DesafioCotacaoWeb.CurrencyPriceController do
  use DesafioCotacaoWeb, :controller

  alias DesafioCotacao.Currency

  def get(conn, %{"currency" => currency}) do
    with {:ok, currency_info} <- Currency.get_currency_info(currency) do
      render(conn, currency_info: currency_info)
    end
  end
end
