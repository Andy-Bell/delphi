defmodule UrlCleaner do


  # def cleaner(partial, prefix) do
  #   partial
  #   # |> String.split("/")
  #   # |> Enum.join("")
  #   |> url_joiner(prefix)
  # end

  def url_joiner(prefix, partial) do
    prefix <> partial
  end

end
