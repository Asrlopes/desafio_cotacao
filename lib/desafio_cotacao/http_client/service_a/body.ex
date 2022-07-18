defmodule DesafioCotacao.HttpClient.ServiceA.Body do
  @type success :: %{
          cotacao: float(),
          moeda: binary(),
          symbol: binary()
        }

  @type error :: %{
          erro: binary()
        }

  @type t :: success() | error()
end
