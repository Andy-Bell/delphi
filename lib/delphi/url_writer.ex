defmodule UrlWriter do

  import Ecto.Query
  import Ecto.Changeset

  def write_url(url) do
    UrlScraper.search_urls(url)
    |> Enum.map( &node_depth(&1) )
    |> Enum.uniq
    |> Enum.each( &url_list(&1) )
    url_list(url)
    UrlScraper.search_urls(url)
  end

  defp url_list(data) do
    %Delphi.UrlWriter{url: data}
    |> clause_match
  end

  defp clause_match(data1) do
    changeset = Delphi.UrlWriter.changeset(data1)
    case Delphi.Repo.insert(changeset) do
      {:ok, _} -> IO.puts("it worked")
      {:error, _} -> IO.puts("failed, possibly unique index...")
    end
  end

  defp node_depth(data) do
    if data do
      if Regex.match?(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)$/, data) do
          Regex.run(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)$/, data, [])
          |> List.first
      else
        node = Regex.run(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)(\/\w+)/, data, [])
        unless(node == nil) do List.first(node) end
      end
    end
  end


end
