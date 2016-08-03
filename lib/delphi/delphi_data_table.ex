defmodule Delphi.DataTable do
  use Ecto.Model
  import Ecto.Changeset

  schema "test" do
    field :title
    field :description
    field :url

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url])
    |> unique_constraint(:url)
  end

end
