defmodule UrlWriter do

  import Ecto.Query
  import Ecto.Changeset
  import Delphi.Repo
  import QueryController

  def write_url(url) do
    UrlScraper.search_urls(url)
    |> Enum.map( &node_depth_one(&1) )
    |> Enum.uniq
    |> Enum.each( &url_list(&1) )
    write_root(url)
    QueryController.search
  end

  defp write_root(url) do
    UrlScraper.search_urls(url)
    |> Enum.map( &node_depth_root(&1) )
    |> Enum.uniq
    |> Enum.each( &url_list(&1) )
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

  defp node_depth_one(data) do
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

  defp node_depth_root(data) do
    if data do
      node = Regex.run(~r/(http[s]?|ftp):\/?\/?([^:\/\s]+)/, data, [])
      unless(node == nil) do List.first(node) end
    end
  end


end
