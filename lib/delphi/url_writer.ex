defmodule UrlWriter do
  import ScraperController

  def add_url_to_table(url) do
    UrlScraper.search_urls(url)
    |> Enum.map( &limit_node_depth_to_one(&1) )
    |> Enum.uniq
    |> Enum.each( &write(&1) )
    add_url_root_to_table(url)
    scrape_page(url)
    exit_function
  end

  defp exit_function do
    IO.puts "Exited function"
  end

  defp add_url_root_to_table(url) do
    UrlScraper.search_urls(url)
    |> Enum.map( &get_url_root_node(&1) )
    |> Enum.uniq
    |> Enum.each( &write(&1) )
  end

  defp write(url) do
    %Delphi.UrlTable{url: url}
    |> clause_match
  end

  defp clause_match(url) do
    changeset = Delphi.UrlTable.changeset(url)
    case Delphi.Repo.insert(changeset) do
      {:ok, _} -> IO.puts("it worked")
      {:error, _} -> IO.puts("failed, possibly unique index...")
    end
  end

  defp limit_node_depth_to_one(url) do
    cond do
      !is_nil(url) && exact_url_root_node_match(url) -> extract_url_root(url)
      true -> extract_first_node(url)
    end
  end

  defp get_url_root_node(url) do
    if url do
      node = Regex.run(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)/, url, [])
      unless(node == nil) do List.first(node) end
    end
  end

  defp exact_url_root_node_match(url) do
    Regex.match?(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)$/, url)
  end

  defp extract_url_root(url) do
    Regex.run(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)$/, url, [])
    |> List.first
  end

  defp extract_first_node(url) do
    node = Regex.run(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)(\/\w+)/, url, [])
    unless(node == nil) do List.first(node) end
  end

end
