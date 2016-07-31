defmodule UrlToDataParse do
  import Ecto.Query

  def fill_the_data_table do
    QueryController.search
    |> Enum.map(fn (x) -> ScraperController.scrape_page(x) end )
    |> IO.inspect 
  end

end
