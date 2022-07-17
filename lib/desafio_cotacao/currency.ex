defmodule DesafioCotacao.Currency do
  alias DesafioCotacao.HttpClient.ServiceA

  def get_currency_info(currency), do: ServiceA.get_currency(currency)
end
