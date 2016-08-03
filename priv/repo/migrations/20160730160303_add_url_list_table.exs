defmodule Delphi.Repo.Migrations.AddUrlListTable do
  use Ecto.Migration

  def change do
    create table(:url_test) do
      add :url, :text

      timestamps
    end
  end
end
