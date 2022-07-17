defmodule DesafioCotacao.CurrencyTest do
  use ExUnit.Case

  alias DesafioCotacao.Currency

  describe "get_currency_info/1" do
    test "return an currency info" do
      currency = "BRL"

      response = Currency.get_currency_info(currency)

      assert {:ok, %{"cotacao" => _cotacao, "moeda" => "BRL", "symbol" => _symbol}} = response
    end

    test "return an message when the given currency is nil" do
      currency = nil

      expected_error_message = "Oh, no! Você precisa informar o parâmetro 'moeda'!"

      response = Currency.get_currency_info(currency)

      assert {:ok, %{"erro" => error_message}} = response
      assert expected_error_message == error_message
    end
  end
end
