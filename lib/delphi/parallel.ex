defmodule Parallel do

  def pmap(collection, function) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
      spawn_link(fn -> (send me, { self, function.(elem)}) end)
    end)
    |> Enum.map(fn (pid) ->
      receive do
        { _pid, result } -> result
      end
    end)

  end
end
