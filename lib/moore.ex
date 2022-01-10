defmodule Moore do
  require Logger

  def day_with_smallest_spread(path) do
    {:ok, file} = Moore.Weather.start_link(path)
    Logger.info("Day with smallest spread is: #{Moore.Weather.result(file)}")
  end

  def team_with_the_smallest_goal_difference(path) do
    {:ok, file} = Moore.Football.start_link(path)
    Logger.info("Team with smallest goal difference is: #{Moore.Football.result(file)}")
  end
end
