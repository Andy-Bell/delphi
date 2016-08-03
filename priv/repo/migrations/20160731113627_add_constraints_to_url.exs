defmodule Delphi.Repo.Migrations.AddConstraintsToUrl do
  use Ecto.Migration

  def change do
    create unique_index(:url_test, [:url])
  end
end
