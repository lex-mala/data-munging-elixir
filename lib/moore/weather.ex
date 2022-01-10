defmodule Moore.Weather do
  @behaviour Moore.File

  @impl true
  def row_to_data(%{"Dy" => name, "MxT" => max, "MnT" => min}) do
    {name, Moore.Utils.abs_diff(max, min)}
  end

  @impl true
  def parse_line(<<
        dy::binary-size(5),
        mxt::binary-size(6),
        mnt::binary-size(6),
        avt::binary-size(6),
        hdday::binary-size(7),
        avdp::binary-size(5),
        hrp::binary-size(5),
        tpcpn::binary-size(6),
        wxtype::binary-size(7),
        pdir::binary-size(5),
        avsp::binary-size(5),
        dir::binary-size(4),
        mxs::binary-size(4),
        skyc::binary-size(5),
        mxr::binary-size(4),
        mnr::binary-size(4),
        avslp::binary-size(5),
        "\n"
      >>) do
    [
      dy,
      mxt,
      mnt,
      avt,
      hdday,
      avdp,
      hrp,
      tpcpn,
      wxtype,
      pdir,
      avsp,
      dir,
      mxs,
      skyc,
      mxr,
      mnr,
      avslp
    ]
  end

  def parse_line(<<
        dy::binary-size(5),
        mxt::binary-size(6),
        mnt::binary-size(6),
        avt::binary-size(6),
        hdday::binary-size(7),
        avdp::binary-size(5),
        hrp::binary-size(5),
        tpcpn::binary-size(6),
        wxtype::binary-size(7),
        pdir::binary-size(5),
        avsp::binary-size(5),
        dir::binary-size(4),
        mxs::binary-size(4),
        skyc::binary-size(4),
        "\n"
      >>) do
    [
      dy,
      mxt,
      mnt,
      avt,
      hdday,
      avdp,
      hrp,
      tpcpn,
      wxtype,
      pdir,
      avsp,
      dir,
      mxs,
      skyc,
      nil,
      nil,
      nil
    ]
  end

  def parse_line(_), do: []
end
