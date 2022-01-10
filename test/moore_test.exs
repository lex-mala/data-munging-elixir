defmodule MooreTest do
  use ExUnit.Case

  test "football/0" do
    assert Moore.football() == "Aston_Villa"
  end

  test "weather/0" do
    assert Moore.weather() == "14"
  end
end
