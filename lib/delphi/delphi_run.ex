defmodule DelphiRun do
  import Ecto.Query

  def spider do
     for _ <- 1..10, do: spider_spawn_config
  end

  defp spider_spawn_config do
    me = self
    QueryController.search
    |> Enum.map(fn (x) -> spawn(fn -> send me, {self, UrlTable.write_url(x)} end ) end)
    |> Enum.map(fn (pid) ->
      IO.inspect(pid)
      receive do
        { pid, result } -> result
      after 50 -> Process.exit(pid, :kill)
      end
    end)
  end

end
