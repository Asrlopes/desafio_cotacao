defmodule DesafioCotacao.HttpClient.ServiceA.Response do
  alias DesafioCotacao.HttpClient.ServiceA.Body

  @fields [
    :headers,
    :status,
    :body
  ]

  @enforce_keys @fields
  defstruct @fields

  @type headers :: [{binary(), binary()}]
  @type status :: integer() | nil
  @type body :: map() | binary()

  @type t :: %__MODULE__{
          headers: headers(),
          status: status(),
          body: Body
        }
end
