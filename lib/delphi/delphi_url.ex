defmodule Delphi.Url do
  import Ecto.Query

  def list do
    query = from u in "url_test",
    select: u.url
    Delphi.Repo.all(query)
  end

end
