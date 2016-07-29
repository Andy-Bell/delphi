defmodule Delphi.Database do
  use Ecto.Model

  schema "test" do
    field :title
    field :description
    field :fulltext
    field :url

    timestamps
  end
end
