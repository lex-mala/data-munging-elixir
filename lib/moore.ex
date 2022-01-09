defmodule Moore do
  require Logger

  def day_with_smallest_spread(path) do
    {:ok, file} = Moore.File.start_link(path)
    Logger.info("Day with smallest spread is: #{Moore.File.result(file)}")
  end
end
