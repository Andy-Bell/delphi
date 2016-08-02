defmodule DelphiSpider do
  import Ecto.Query

  # def unleash_the_kraken do
  #   spawn(combined_method)
  # end
  #
  # def combined_method
  # end

  def fill_the_data_table do
    QueryController.search
    |> Enum.map(fn (x) -> ScraperController.scrape_page(x) end )
  end

  def fill_the_url_table do
     QueryController.search
     |> Enum.map(fn (x) -> UrlWriter.write_url(x) end )
  end

end
