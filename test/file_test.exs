defmodule Moore.FileTest do
  use ExUnit.Case

  describe "start_link/1" do
    test "works when a file is present" do
      assert {:ok, _} = Moore.File.start_link("./priv/weather.dat")
    end

    test "fails when a file is not present" do
      assert {:error, _} = Moore.File.start_link("./priv/im_not_real.dat")
    end
  end
end
