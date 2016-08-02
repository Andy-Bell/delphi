# defmodule Parallel do
#
# #   def map(collection) do
# #     collection
# #     |> Enum.map(Task.async(DelphiSpider.fill_the_data_table))
# #     |> Enum.map(&Task.await(&1))
# #     fn(x) -> IO.puts("Process complete") end
# #   end
# # end
#
#
#   def pmap(collection, function) do
#     me = self
#     collection
#     |> Enum.map(fn (elem) ->
#       IO.inspect(elem)
#       IO.puts "===================="
#       spawn(fn -> (send me, { self, function.(elem) }) end)
#     end)
#     |> Enum.map(fn (pid) ->
#       IO.inspect(pid)
#       receive do
#         { pid, result } -> result
#       end
#     end)
#
#   end
# end

# Parallel.pmap(UrlWriter.write_url("http://www.makersacademy.com"), DelphiSpider.fill_the_data_table)
# Parallel.pmap(UrlWriter.write_url("http://www.dustyfeet.com"), DelphiSpider.fill_the_data_table)
