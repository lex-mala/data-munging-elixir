defmodule Moore.File do
  use Agent

  def start_link(path) do
    with {:ok, bin} <- File.read(path) do
      Agent.start_link(fn -> bin end)
    end
  end
end
