defmodule DesafioCotacaoWeb.CurrencyPriceView do
  use DesafioCotacaoWeb, :view

  def render("get.json", %{currency_info: currency_info}), do: currency_info
end
