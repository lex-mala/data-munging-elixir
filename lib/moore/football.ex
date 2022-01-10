defmodule Moore.Football do
  use Agent

  @divider "-------------------------------------------------------"

  def start_link(path) do
    with {:ok, bin} <- File.read(path),
         ls <- String.split(bin, "\n"),
         trimmed <- Enum.map(ls, fn l -> String.replace(l, ~r/[ ]+/, " ") |> String.trim() end),
         [_ | rows] <- Enum.map(trimmed, &String.split(&1, " ")),
         without_divider <- Enum.reject(rows, &(&1 == [@divider] or &1 == [""])),
         diffs <- Enum.map(without_divider, &parse_row/1),
         [{name, _} | _] <- Enum.sort_by(diffs, fn {_, diff} -> diff end, :asc) do
      Agent.start_link(fn -> %{data: diffs, result: name} end)
    end
  end

  def result(pid) do
    Agent.get(pid, & &1.result)
  end

  defp parse_row([_num, name, _played, _wins, _losses, _draws, forced, "-", allowed, _pts]) do
    with {f, _} <- Integer.parse(forced),
         {a, _} <- Integer.parse(allowed) do
      {name, abs(f - a)}
    end
  end
end
