defmodule Moore do
  alias Moore.{Football, Weather}

  def football, do: Football.parse("priv/football.dat")
  def weather, do: Weather.parse("priv/weather.dat")
end
