defmodule DelphiSpider do
  import Ecto.Query

  alias Parallel

  # def spider do
  #   pmap(x, fill_tables)
  # end

  def fill_the_data_table do
    me = self
    QueryController.search
    |> Enum.map(fn (x) -> spawn(fn -> send me, {self, ScraperController.scrape_page(x)} end ) end)
    |> Enum.map(fn (pid) ->
           receive do
             { pid, result } -> result
           after 500 -> Process.exit(pid, :kill)
           end
         end)
  end

  def fill_the_url_table do
    me = self
    QueryController.search
    |> Enum.map(fn (x) -> spawn(fn -> send me, {self, UrlWriter.write_url(x)} end ) end)
    |> Enum.map(fn (pid) ->
      IO.inspect(pid)
      receive do
       { pid, result } -> result
     after 50 -> Process.exit(pid, :kill)
      end
     end)
  end


  def spider do
     for x <- 1..10, do: fill_the_url_table
  end


end
