defmodule DesafioCotacao.Utils.Parser do
  def parse_float_to_int(value) do
    value
    |> Float.to_string()
    |> String.replace(".", "")
    |> String.to_integer()
  end

  def parse_string_to_int(value), do: String.to_integer(value)

  def parse_int_to_float(value), do: value / 1000
end
