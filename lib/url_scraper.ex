defmodule UrlScraper do

  def search_urls(url) do
    HTTPoison.start
    (HTTPoison.get! url).body
    |> Floki.find("a")
    |> Enum.each(&extract_url(&1))
  end

  defp extract_url(tuple) do
    elem(tuple, 1)
    |> Enum.filter(&parse_tuple(&1))
    |> Enum.each(fn(y) -> IO.inspect(elem(y,1)) end)
  end

  defp parse_tuple({"href", _}), do: true
  defp parse_tuple({_, _}), do: false

end
