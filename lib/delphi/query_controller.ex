defmodule QueryController do
  import Ecto.Query

  def search do
    query = from u in "url_test",
    select: u.url
    Delphi.Repo.all(query)
  end

end
