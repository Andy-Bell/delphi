defmodule UrlScraper do

  def search_urls(url) do
    HTTPoison.start
    (HTTPoison.get! url, [], hackney: [:insecure]).body
    |> Floki.find("a")
    |> Enum.map(&extract_url(&1))
    |> List.flatten
    |> filter_urls(url)
    |> Enum.filter( fn x -> x != nil end)
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
    |> Enum.filter(&match_partial_url(&1))
    |> Enum.partition(&match_full_url(&1))
    |> concatenate_urls(url)
    |> Enum.map( &check_node_depth(&1) )
  end

  defp check_node_depth(url) do
    node = Regex.run(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)(\/\w+)/, url, [])
    unless(node == nil) do List.first(node) end
  end

  defp match_partial_url(url) do
    Regex.match?(~r/\//, url)
  end

  defp match_full_url(url) do
    Regex.match?(~r/https?:\/\/.+/, url)
  end

  defp concatenate_urls({full_url, partial_url}, page_url) do
    Enum.map(partial_url, &complete_partial_urls(&1, page_url))
    ++ Enum.map(full_url, fn(full_url) -> full_url end)
  end

  defp complete_partial_urls(partial_url, page_url) do
    page_url <> partial_url
  end
end
