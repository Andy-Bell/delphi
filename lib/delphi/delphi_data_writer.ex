defmodule Delphi.DataWriter do
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
    |> cast(params, [:url, :title, :description])
    |> unique_constraint(:url)
    |> unique_constraint(:title)
    |> unique_constraint(:description)
  end

end
