defmodule DesafioCotacao.Currency do
  alias DesafioCotacao.HttpClient.ServiceA.Api

  def get_currency_info(currency), do: Api.get_currency(currency)
end
