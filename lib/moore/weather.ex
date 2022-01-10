defmodule Moore.Weather do
  use Agent

  def start_link(path) do
    with stream <- File.stream!(path, [], :line),
         [headers | data] <- parse(stream),
         parsed_data <- Enum.map(data, fn row -> headers |> Enum.zip(row) |> Enum.into(%{}) end),
         without_month <- Enum.reject(parsed_data, &match?("mo", Map.get(&1, "Dy"))),
         diffs <- Enum.map(without_month, &diff/1),
         [%{day: day} | _] <- Enum.sort_by(diffs, fn %{spread: s} -> s end, :asc) do
      Agent.start_link(fn -> %{data: parsed_data, result: day} end)
    end
  end

  def result(pid) do
    Agent.get(pid, & &1.result)
  end

  defp diff(%{"Dy" => day, "MxT" => max, "MnT" => min}) do
    spread =
      if is_nil(max) or is_nil(min) do
        nil
      else
        with {max, _} <- Integer.parse(max),
             {min, _} <- Integer.parse(min) do
          max - min
        else
          :error -> nil
        end
      end

    %{day: day, spread: spread}
  end

  defp parse(stream) do
    stream
    |> Enum.reject(&match?("\n", &1))
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn line ->
      for val <- line do
        cond do
          is_binary(val) and String.trim(val) == "" -> nil
          is_binary(val) -> String.trim(val)
          true -> val
        end
      end
    end)
  end

  defp parse_line(<<
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

  defp parse_line(<<
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
end
