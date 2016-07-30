defmodule UrlCleaner do

  def cleaner(partial, prefix) do
    partial
    |> String.split("/")
    |> Enum.join("")
    |> url_joiner(prefix)
  end

  defp url_joiner(raw, prefix) do
    prefix <> raw
  end

end
