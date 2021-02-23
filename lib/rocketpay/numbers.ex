defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, string_values}) do
  sum =
    string_values
    |> String.split(",")
    |> Stream.map(fn string_value -> String.to_integer(string_value) end)
    |> Enum.sum()
  {:ok, %{sum: sum}}
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid filename!"}}
end
