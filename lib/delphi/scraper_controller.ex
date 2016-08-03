defmodule ScraperController do
  import Ecto.Query
  import Ecto.Changeset

  def scrape_page(url) do
    Scrape.website(url)
    |> criteria
  end

  defp criteria(data) do
    %Delphi.DataWriter{title: data.title,
    description: data.description,
    url: data.url}
    |> clause_match
  end

  defp clause_match(data1) do
    changeset = Delphi.DataWriter.changeset(data1)
    case Delphi.Repo.insert(changeset) do
      {:ok, _} -> IO.puts("======================it worked======================")
      {:error, _} -> IO.puts("failed, possibly unique index...")
    end
  end

end
