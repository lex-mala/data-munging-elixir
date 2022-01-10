defmodule Moore.File do
  @type data() :: {name :: String.t(), value :: integer()}
  @type line() :: [String.t()]
  @type row() :: %{optional(String.t()) => String.t()}

  @callback parse_line(String.t()) :: [String.t()]
  @callback row_to_data(row()) :: data()

  @spec parse(module, Path.t()) :: String.t()
  def parse(mod, path) do
    with stream <- File.stream!(path),
         parsed <- Enum.map(stream, &mod.parse_line/1),
         casted <- Enum.map(parsed, fn line -> Enum.map(line, &cast/1) end),
         [headers | lines] <- Enum.reject(casted, &(&1 == [])),
         zipped <- zip(headers, lines),
         [{result, _} | _] <- sort(zipped, mod) do
      result
    end
  end

  defp cast(val, stop \\ false)
  defp cast(nil, _), do: nil
  defp cast("", _), do: nil
  defp cast(str, false), do: str |> String.trim() |> cast(true)
  defp cast(str, _), do: str

  defp sort(rows, mod) do
    rows |> Enum.map(&mod.row_to_data/1) |> Enum.sort_by(&elem(&1, 1), :asc)
  end

  defp zip(headers, lines) do
    for line <- lines, do: headers |> Enum.zip(line) |> Enum.into(%{})
  end
end
