defmodule DelphiSpider do
  import Ecto.Query

  def unleash_the_kraken do
    Enum.each(fill_the_url_table,
      spawn(fill_the_data_table)
      )
  end

  def fill_the_data_table do

    QueryController.search
    |> Enum.map(fn (x) -> ScraperController.scrape_page(x) end )
  end

  def fill_the_url_table do
     QueryController.search
     |> Enum.map(fn (x) -> UrlWriter.write_url(x) end )
  end

end
