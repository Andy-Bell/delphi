defmodule Delphi do

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Delphi.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Delphi.Supervisor]
    Supervisor.start_link(children, opts)

  end
end
