defmodule MooreTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  test "day_with_smallest_spread/1" do
    path = "./priv/weather.dat"

    assert capture_log(fn -> Moore.day_with_smallest_spread(path) end) =~
             "Day with smallest spread is: 14"
  end

  test "team_with_the_smallest_goal_difference/1" do
    path = "./priv/football.dat"

    assert capture_log(fn -> Moore.team_with_the_smallest_goal_difference(path) end) =~
             "Team with smallest goal difference is: Aston_Villa"
  end
end
