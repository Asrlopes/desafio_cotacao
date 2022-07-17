defmodule DesafioCotacaoWeb.CurrencyPriceControllerTest do
  use DesafioCotacaoWeb.ConnCase

  describe "get" do
    test "returns currency data", %{conn: conn} do
      currency = "BRL"
      conn = get(conn, Routes.currency_price_path(conn, :get, currency))

      assert %{"cotacao" => _cotacao, "moeda" => _moeda, "symbol" => _symbol} =
               json_response(conn, 200)
    end
  end
end
