defmodule Moore.FootballTest do
  use ExUnit.Case

  setup do
    [path: "./priv/football.dat"]
  end

  describe "start_link/1" do
    test "works when a file is present", %{path: path} do
      assert start_supervised!({Moore.Football, path})
    end

    test "raises when a file is not present" do
      assert {:error, _} = Moore.Football.start_link("./priv/im_not_real.dat")
    end
  end

  test "result/1", %{path: path} do
    file = start_supervised!({Moore.Football, path})
    assert Moore.Football.result(file) == "Aston_Villa"
  end
end
