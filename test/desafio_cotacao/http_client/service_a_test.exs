defmodule DesafioCotacao.HttpClient.ServiceATest do
  use ExUnit.Case, async: true

  alias DesafioCotacao.HttpClient.ServiceA.Client

  describe "get_currency/2" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "returns currency info", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      currency = "BRL"

      body = ~S({
        "cotacao":3.124,
        "moeda":"BRL",
        "symbol":"\uD83D\uDCB5"
      })

      Bypass.expect(bypass, "GET", "/cotacao", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      expected_response = {:ok, %{"cotacao" => 3.124, "moeda" => "BRL", "symbol" => "💵"}}

      assert Client.get_currency(url, currency) == expected_response
    end

    test "returns a message when the currency parameter its not given", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      body = ~S({
        "erro":"Oh, no! Você precisa informar o parâmetro 'moeda'!"
      })

      Bypass.expect(bypass, "GET", "/cotacao", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(400, body)
      end)

      expected_response = {:ok, %{"erro" => "Oh, no! Você precisa informar o parâmetro 'moeda'!"}}

      assert Client.get_currency(url, nil) == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
