defmodule DesafioCotacao.Currency do
  alias DesafioCotacao.HttpClient.ServiceA.Api, as: ApiServiceA
  alias DesafioCotacao.HttpClient.ServiceB.Api, as: ApiServiceB
  alias DesafioCotacao.Utils.Parser

  def get_currency_info(currency) do
    tasks = [
      Task.async(fn -> ApiServiceA.get_currency(currency) end),
      Task.async(fn -> ApiServiceB.get_currency(currency) end)
    ]

    tasks
    |> Task.await_many()
    |> handle_with_currency()
  end

  defp handle_with_currency([{:ok, currency_a}, {:ok, currency_b}]) do
    list_of_currency = [
      currency_a,
      currency_b
    ]

    Enum.reduce(list_of_currency, fn currency, acc ->
      if currency["cotacao"] < acc["cotacao"] do
        {:ok, normalize_response(currency)}
      else
        {:ok, normalize_response(acc)}
      end
    end)
  end

  defp normalize_response(%{"cotacao" => currency_value, "moeda" => currency}) do
    %{
      "cotacao" => Parser.parse_int_to_float(currency_value),
      "moeda" => currency
    }
  end

  defp normalize_response(message), do: message
end
