defmodule Moore do
  require Logger

  def day_with_smallest_spread(path) do
    {:ok, file} = Moore.Weather.start_link(path)
    Logger.info("Day with smallest spread is: #{Moore.Weather.result(file)}")
  end
end
