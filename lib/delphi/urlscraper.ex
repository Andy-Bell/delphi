defmodule UrlScraper do

  def search_urls(url) do
    HTTPoison.start
    (HTTPoison.get! url).body
    |> Floki.find("a")
    |> Enum.map(&extract_url(&1))
    |> List.flatten
  end

  defp extract_url(tuple) do
    elem(tuple, 1)
    |> Enum.filter(&parse_tuple(&1))
    |> Enum.map(fn(y) -> elem(y,1) end)
  end

  defp parse_tuple({"href", _}), do: true
  defp parse_tuple({_, _}), do: false

end
