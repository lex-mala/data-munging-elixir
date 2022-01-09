defmodule Moore.FileTest do
  use ExUnit.Case

  @headers ~w(Dy MxT MnT AvT HDDay AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP)

  setup do
    [path: "./priv/weather.dat"]
  end

  describe "start_link/1" do
    test "works when a file is present", %{path: path} do
      assert start_supervised!({Moore.File, path})
    end

    test "raises when a file is not present" do
      assert_raise File.Error, fn -> Moore.File.start_link("./priv/im_not_real.dat") end
    end

    test "splits the file", %{path: path} do
      file = start_supervised!({Moore.File, path})

      for row <- file |> :sys.get_state() |> Map.get(:data) do
        for header <- @headers do
          assert header in Map.keys(row)
        end
      end
    end
  end

  test "result/1", %{path: path} do
    file = start_supervised!({Moore.File, path})
    assert Moore.File.result(file) == "14"
  end
end
