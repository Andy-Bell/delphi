defmodule ScraperController do
  import Ecto.Query

  def scrape_page(url) do
    Scrape.website(url)
    |> criteria
    |> clause_match
  end

  defp criteria(data) do
    %Delphi.DataWriter{title: data.title,
    description: data.description,
    url: data.url}
  end

  defp clause_match(data1) do
    {:ok, inserted_data} = Delphi.Repo.insert(data1)
  end
  
end
