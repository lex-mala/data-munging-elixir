defmodule Moore.Utils do
  def abs_diff(a, b) when is_binary(a) and is_binary(b) do
    with {a, _} <- Integer.parse(a),
         {b, _} <- Integer.parse(b),
         diff <- abs(a - b) do
      diff
    end
  end
end
