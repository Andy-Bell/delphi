defmodule QueryController do
  import Ecto.Query

  def search do
    query = from test in "test",
    where: test.title == "Makers Academy",
    select: test.url
    Delphi.Repo.all(query)
  end

end
