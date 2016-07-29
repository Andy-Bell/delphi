defmodule Delphi.Repo.Migrations.RemoveTags do
  use Ecto.Migration

  def change do
    alter table(:test) do
      remove :tags
    end
  end
end
