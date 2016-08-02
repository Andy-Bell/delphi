defmodule Parallel do

  def pmap(collection, function) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (send me, { self, function.(elem)}) end
      |> IO.inspect
    end)
    |> Enum.map(fn (pid) ->
      receive do { _pid, result } -> result end
      |> IO.inspect
      IO.inspect(pid)
    end)

  end
end
