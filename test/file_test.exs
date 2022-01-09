defmodule Moore.FileTest do
  use ExUnit.Case

  @headers ~w(Dy MxT MnT AvT HDDay AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP)

  describe "start_link/1" do
    setup do
      [path: "./priv/weather.dat"]
    end

    test "works when a file is present", %{path: path} do
      assert {:ok, _} = Moore.File.start_link(path)
    end

    test "raises when a file is not present" do
      assert_raise File.Error, fn -> Moore.File.start_link("./priv/im_not_real.dat") end
    end

    test "splits the file", %{path: path} do
      {:ok, file} = Moore.File.start_link(path)
      assert {@headers, data} = :sys.get_state(file)
    end
  end
end
