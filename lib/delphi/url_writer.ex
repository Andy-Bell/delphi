defmodule UrlWriter do

  import Ecto.Query
  import Ecto.Changeset

  def write_url(url) do
    UrlScraper.search_urls(url)
    |> Stream.uniq
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

end
