defmodule Delphi.Repo.Migrations.CreateSchema do
  use Ecto.Migration

  def change do
    create table(:test) do
      add :title, :string
      add :description, :text
      add :fulltext, :text
      add :tags, :text
      add :url, :text

      timestamps
    end
  end
end
