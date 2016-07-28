defmodule UrlScraperTest do
  use ExUnit.Case
  doctest UrlScraper

  test "pulls the correct urls" do
    data = UrlScraper.search_urls("http://www.makersacademy.com")
    assert(Enum.any?(data,fn x -> x == "http://www.github.com/makersacademy" end))
  end
end
