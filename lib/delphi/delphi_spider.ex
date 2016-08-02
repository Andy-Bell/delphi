defmodule DelphiSpider do
  import Ecto.Query

  alias Parallel

  # def spider do
  #   pmap(x, fill_tables)
  # end

  # def fill_tables do
  #   fill_the_url_table
  #   fill_the_data_table
  # end

  def fill_the_data_table do
    me = self
    QueryController.search
    |> Enum.map(fn (x) -> spawn(fn -> send me, {self, ScraperController.scrape_page(x)} end ) end)
    |> Enum.map(fn (pid) ->
           IO.inspect(pid)
           receive do
             { pid, result } -> result
           after 5000 -> {:error, :process_failed}         
           end
         end)
    #  fn(x) -> IO.puts("Process complete") end
     fn(x) -> x end
  end

  def fill_the_url_table do
    QueryController.search
    |> Enum.map(fn (x) -> UrlWriter.write_url(x) end )
  end

end
