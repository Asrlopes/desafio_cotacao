defmodule DesafioCotacao.HttpClient.ServiceA.Client do
  defstruct url: nil, currency: nil

  @type currency :: String.t() | nil

  @type t :: %__MODULE__{url: String.t(), currency: currency()}
end
