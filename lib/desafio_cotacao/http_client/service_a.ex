defmodule DesafioCotacao.HttpClient.ServiceA do
  use Tesla

  @base_url "http://localhost:8080/servico-a"

  plug Tesla.Middleware.JSON

  def get_currency_price(url \\ @base_url, currency) do
    query_params = [moeda: currency]

    case is_binary(currency) do
      true ->
        "#{url}/cotacao"
        |> get(query: query_params)
        |> handle_get()

      false ->
        "#{url}/cotacao"
        |> get()
        |> handle_get()
    end
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_get({:ok, %Tesla.Env{status: 400, body: body}}), do: {:ok, body}
end
