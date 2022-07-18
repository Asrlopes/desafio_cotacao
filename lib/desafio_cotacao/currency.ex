defmodule DesafioCotacao.Currency do
  alias DesafioCotacao.HttpClient.ServiceA.Client

  def get_currency_info(currency), do: Client.get_currency(currency)
end
