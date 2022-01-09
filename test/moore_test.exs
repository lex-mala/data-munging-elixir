defmodule MooreTest do
  use ExUnit.Case
  doctest Moore

  test "greets the world" do
    assert Moore.hello() == :world
  end
end
