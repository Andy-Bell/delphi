defmodule Delphi.Repo.Migrations.RemoveFullTextFromDataWriter do
  use Ecto.Migration

  def change do
    alter table(:test) do
      remove :fulltext
    end
  end
end
