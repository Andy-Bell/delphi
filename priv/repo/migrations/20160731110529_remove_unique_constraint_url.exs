defmodule Delphi.Repo.Migrations.RemoveUniqueConstraintUrl do
  use Ecto.Migration

  def change do
    drop unique_index(:url_test, [:url])
  end
end
