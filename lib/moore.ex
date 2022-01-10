defmodule Moore do
  alias Moore.{File, Football, Weather}

  def football, do: File.parse(Football, "priv/football.dat")
  def weather, do: File.parse(Weather, "priv/weather.dat")
end
