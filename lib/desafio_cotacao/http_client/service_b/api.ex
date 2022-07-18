defmodule DesafioCotacao.HttpClient.ServiceB.Api do
  use Tesla

  alias DesafioCotacao.HttpClient.ServiceB.Body
  alias DesafioCotacao.HttpClient.ServiceB.Client
  alias DesafioCotacao.HttpClient.ServiceB.Response
  alias DesafioCotacao.Utils.Parser

  @base_url "http://localhost:8080/servico-b"

  plug Tesla.Middleware.JSON

  @spec get_currency(Client.t()) :: Response.t()
  def get_currency(url \\ @base_url, currency) do
    query_params = [curr: currency]

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
  defp handle_get({:ok, %Tesla.Env{status: 422, body: body}}), do: {:ok, normalize_body(body)}

  @spec normalize_body(Body.t()) :: %{cotacao: Body.cotacao()}
  defp normalize_body(%{
         "cotacao" => %{"fator" => _fator, "currency" => currency, "valor" => currency_value}
       }) do
    %{
      "cotacao" => Parser.parse_string_to_int(currency_value),
      "moeda" => currency
    }
  end

  @spec normalize_body(Body.t()) :: Body.error()
  defp normalize_body(%{"message" => _message, "success" => _success} = error), do: error
end
