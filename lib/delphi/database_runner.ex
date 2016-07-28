defmodule Delphi.DatabaseRunner do

  alias Delphi.Database
  alias RethinkDB.Query

  def start(_type, _args) do
    Delphi.Supervisor.start_link
  end

  def database_insert(conn, params) do
    q = Query.table("test")
    |> Query.insert(params)
    |> Database.run(conn)

  end

  def database_view(conn) do
    q = Query.table("test")
    |> Database.run(conn)

  end

end
