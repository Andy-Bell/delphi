defmodule UrlScraper do

  def search_urls(url) do
    HTTPoison.start
    (HTTPoison.get! url).body
    |> Floki.find("a")
    |> Enum.map(&extract_url(&1))
    |> List.flatten
    |> filter_urls(url)
  end

  defp extract_url(tuple) do
    elem(tuple, 1)
    |> Enum.filter(&parse_tuple(&1))
    |> Enum.map(fn(y) -> elem(y,1) end)
  end

  defp parse_tuple({"href", _}), do: true
  defp parse_tuple({_, _}), do: false

  defp filter_urls(data, url) do
    Stream.uniq(data)
    |> Enum.filter(&partial_url(&1))
    |> Enum.partition(&full_url(&1))
    |> create_urls(url)
  end

  defp partial_url(data) do
    Regex.match?(~r/\//, data)
  end

  defp full_url(data) do
    Regex.match?(~r/https?:\/\/.+/, data)
  end

  defp create_urls({a, b}, url) do
    Enum.map(b, fn(b) -> url <> b end) ++ Enum.map(a, fn(a) -> a end)
  end

end
