defmodule Moore.File do
  use Agent

  def start_link(path) do
    with stream <- File.stream!(path, [], :line),
         lines <- Enum.map(stream, &String.replace(&1, ~r/([ ]+|\n)/, " ")),
         [headers, _empty | data] <- Enum.map(lines, &String.trim/1),
         [headers | data] <- Enum.map([headers | data], &String.split(&1, " ")) do
      Agent.start_link(fn -> {headers, data} end)
    end
  end
end
