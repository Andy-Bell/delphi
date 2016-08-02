defmodule DelphiSpider do
  import Ecto.Query

  alias Parallel

  # def spider do
  #   pmap(x, fill_tables)
  # end

  def fill_tables do
    fill_the_url_table
    fill_the_data_table
  end

  def fill_the_data_table do
    QueryController.search
    |> Enum.map(fn (x) -> ScraperController.scrape_page(x) end )
    fn(x) -> IO.puts("Child exited") end
  end

  def fill_the_url_table do
    QueryController.search
    |> Enum.map(fn (x) -> UrlWriter.write_url(x) end )
    fn(x) -> IO.puts("child exited") end
  end

end
