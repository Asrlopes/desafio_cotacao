defmodule DesafioCotacao.HttpClient.ServiceA.Api do
  use Tesla

  alias DesafioCotacao.HttpClient.ServiceA.Body
  alias DesafioCotacao.HttpClient.ServiceA.Client
  alias DesafioCotacao.HttpClient.ServiceA.Response
  alias DesafioCotacao.Utils.Parser

  @base_url "http://localhost:8080/servico-a"

  plug Tesla.Middleware.JSON

  @spec get_currency(Client.t()) :: Response.t()
  def get_currency(url \\ @base_url, currency) do
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

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, normalize_body(body)}
  defp handle_get({:ok, %Tesla.Env{status: 400, body: body}}), do: {:ok, body}

  @spec normalize_body(Body.t()) :: %{cotacao: integer(), currency: binary()}
  defp normalize_body(%{"cotacao" => currency_value, "moeda" => currency, "symbol" => _symbol}) do
    %{
      "cotacao" => Parser.parse_float_to_int(currency_value),
      "moeda" => currency
    }
  end

  @spec normalize_body(Body.t()) :: %{error: binary()}
  defp normalize_body(%{"erro" => _error_message} = error), do: error
end
