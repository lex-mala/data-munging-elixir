defmodule Moore.File do
  @type t() :: [%{optional(String.t()) => String.t()}]

  @callback parse_line(String.t()) :: [String.t()]
  @callback result(t()) :: String.t()

  @spec parse(module, Path.t()) :: String.t()
  def parse(mod, path) do
    with stream <- File.stream!(path),
         parsed <- Enum.map(stream, &mod.parse_line/1),
         casted <- Enum.map(parsed, fn line -> Enum.map(line, &cast/1) end),
         [headers | data] <- Enum.reject(casted, &(&1 == [])),
         zipped <- Enum.map(data, fn row -> headers |> Enum.zip(row) |> Enum.into(%{}) end),
         result <- mod.result(zipped) do
      result
    end
  end

  defp cast(val, stop \\ false)
  defp cast(nil, _), do: nil
  defp cast("", _), do: nil
  defp cast(str, false), do: str |> String.trim() |> cast(true)
  defp cast(str, _), do: str
end
