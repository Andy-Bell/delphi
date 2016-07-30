defmodule UrlWriter do

  import Ecto.Query

  def write_url(url) do
    UrlScraper.search_urls(url)
    |> Enum.each( &url_list(&1) )
  end

  defp url_list(data) do
    %Delphi.UrlWriter{url: data}
    |> clause_match
  end

  defp clause_match(data1) do
    {:ok, inserted_data} = Delphi.Repo.insert(data1)
  end

end
