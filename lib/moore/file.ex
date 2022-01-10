defmodule Moore.File do
  @type data() :: {name :: String.t(), value :: integer()}
  @type line() :: [String.t()]
  @type row() :: %{optional(String.t()) => String.t()}

  @callback parse(Path.t()) :: String.t()
  @callback parse_line(String.t()) :: [String.t()] | []
  @callback row_to_data(row()) :: data()

  defmacro __using__(_) do
    alias Moore.File, as: P

    quote generated: true do
      @behaviour Moore.File

      @spec parse(Path.t()) :: String.t()
      def parse(path) do
        with stream <- File.stream!(path),
             parsed <- Enum.map(stream, &__MODULE__.parse_line/1),
             casted <- Enum.map(parsed, fn line -> Enum.map(line, &P.cast/1) end),
             [headers | lines] <- Enum.reject(casted, &(&1 == [])),
             zipped <- P.zip(headers, lines),
             [{result, _} | _] <- sort(zipped) do
          result
        end
      end

      defp sort(rows) do
        rows |> Enum.map(&__MODULE__.row_to_data/1) |> Enum.sort_by(&elem(&1, 1), :asc)
      end
    end
  end

  @spec cast(nil | String.t(), boolean()) :: nil | String.t()
  def cast(val, stop \\ false)
  def cast(nil, _), do: nil
  def cast("", _), do: nil
  def cast(str, false), do: str |> String.trim() |> cast(true)
  def cast(str, _), do: str

  @spec zip([String.t()], [String.t()]) :: [map()]
  def zip(headers, lines) do
    for line <- lines, do: headers |> Enum.zip(line) |> Enum.into(%{})
  end
end
