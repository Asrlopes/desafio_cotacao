defmodule DesafioCotacao.HttpClient.ServiceB.Body do
  @type cotacao :: %{
          fator: integer(),
          currency: binary(),
          valor: binary()
        }

  @type success :: %{
          cotacao: cotacao()
        }

  @type error :: %{
          success: binary(),
          message: binary()
        }

  @type t :: success() | error()
end
