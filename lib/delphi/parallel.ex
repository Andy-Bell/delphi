defmodule Parallel do

  def pmap(collection, function) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
      spawn(fn -> (send me, { self, if function.(elem) do function.(elem) end }) end)
    end)
    |> Enum.map(fn (pid) ->
      receive do
        { pid, result } -> result
      end
    end)

  end
end
# Parallel.pmap(UrlWriter.write_url("http://www.makersacademy.com"), DelphiSpider.fill_the_data_table)
# Parallel.pmap(UrlWriter.write_url("http://www.dustyfeet.com"), DelphiSpider.fill_the_data_table)
