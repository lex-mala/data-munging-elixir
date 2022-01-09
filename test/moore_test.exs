defmodule MooreTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  test "day_with_smallest_spread/1" do
    path = "./priv/weather.dat"

    assert capture_log(fn -> Moore.day_with_smallest_spread(path) end) =~
             "Day with smallest spread is: 14"
  end
end
