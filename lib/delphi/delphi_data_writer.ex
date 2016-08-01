defmodule Delphi.DataWriter do
  use Ecto.Model

  schema "test" do
    field :title
    field :description
    field :url

    timestamps
  end

end
