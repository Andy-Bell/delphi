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
    Enum.uniq(data)
    |> Enum.filter(&legit_url(&1))
  end

  defp legit_url(data) do
    # Regex.match?(~r/\//, data)
    Regex.match?(~r/https?:\/\/.+/, data)
  end

  # map fn(x) if include "http" -> leave else return url ++ x end
end
