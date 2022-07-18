defmodule DesafioCotacao.HttpClient.ServiceBTest do
  use ExUnit.Case, async: true

  alias DesafioCotacao.HttpClient.ServiceB

  describe "get_currency/2" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "returns currency info", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      currency = "BRL"

      body = ~S({
          "cotacao": {
            "currency": "BRL",
            "fator": 1000,
            "valor": "3519"
          }
        })

      Bypass.expect(bypass, "GET", "/cotacao", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      expected_response =
        {:ok, %{"cotacao" => %{"currency" => "BRL", "fator" => 1000, "valor" => "3519"}}}

      assert ServiceB.get_currency(url, currency) == expected_response
    end

    test "returns a message when the currency parameter its not given", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      body = ~S({
          "message": "📣 Oh, no! Você precisa informar o parâmetro 'curr'!",
          "success": false
        })

      Bypass.expect(bypass, "GET", "/cotacao", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(422, body)
      end)

      expected_response =
        {:ok,
         %{"message" => "📣 Oh, no! Você precisa informar o parâmetro 'curr'!", "success" => false}}

      assert ServiceB.get_currency(url, nil) == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
