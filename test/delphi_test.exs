defmodule DelphiTest do
  use ExUnit.Case, async: true

  alias Delphi.Database
  alias RethinkDB.Query
  alias RethinkDB.Record
  alias RethinkDB.Collection
  use RethinkDB.Connection
  import RethinkDB.Query
  require RethinkDB.Lambda

  @db_name "delphi_test"
  @table_name "test"

  setup_all do
    start_link
    conn = Database.init(@db_name)
    table(@table_name) |> delete |> Delphi.Database.run(conn)
    on_exit fn ->
      start_link
      table_drop(@table_name) |> run
    end
    :ok
  end


  test "adds to database and asserts the data is included" do
    sample_data = %{
      url: "test1", title: "test2", content: "daniel is nice, merve is great"
    }
    conn = Database.init(@db_name)

    Delphi.database_insert(conn, sample_data)
    q = table(@table_name)
    |> filter( %{url: "test1" })
    |> Delphi.Database.run(conn)

    e = elem(q, 1).data
    |> List.first

    assert e["url"] == "test1"

 end

end
