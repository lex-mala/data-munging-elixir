defmodule Moore.Football do
  use Moore.File

  @impl true
  def row_to_data(%{"Team" => name, "F" => forced, "A" => allowed}) do
    {name, Moore.Utils.abs_diff(forced, allowed)}
  end

  @impl true
  def parse_line(<<_::binary-size(3), "-", _::binary>>), do: []

  def parse_line(<<
        _::binary-size(7),
        team::binary-size(16),
        played::binary-size(6),
        wins::binary-size(4),
        losses::binary-size(4),
        draws::binary-size(6),
        forced::binary-size(2),
        _::binary-size(5),
        allowed::binary-size(6),
        points::binary-size(3),
        "\n"
      >>) do
    [
      team,
      played,
      wins,
      losses,
      draws,
      forced,
      allowed,
      points
    ]
  end

  def parse_line(<<
        _::binary-size(7),
        team::binary-size(16),
        played::binary-size(6),
        wins::binary-size(4),
        losses::binary-size(4),
        draws::binary-size(6),
        forced::binary-size(2),
        _::binary-size(5),
        allowed::binary-size(6),
        points::binary-size(2),
        "\n"
      >>) do
    [
      team,
      played,
      wins,
      losses,
      draws,
      forced,
      allowed,
      points
    ]
  end

  def parse_line(_), do: []
end
