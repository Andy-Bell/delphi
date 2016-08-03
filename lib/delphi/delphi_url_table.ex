defmodule Delphi.UrlTable do
  use Ecto.Model
  import Ecto.Changeset

  schema "url_test" do
    field :url

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url])
    |> unique_constraint(:url)
  end

end
