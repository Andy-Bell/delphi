defmodule Delphi.DatabaseRunner do

  alias Delphi.Database
  alias RethinkDB.Query

  def start(_type, _args) do
    Delphi.Supervisor.start_link
  end

  def database_insert(conn, table, params) do
    q = Query.table(table)
    |> Query.insert(params)
    |> Database.run(conn)

  end

  def database_view(conn, table) do
    q = Query.table(table)
    |> Database.run(conn)

  end

end
