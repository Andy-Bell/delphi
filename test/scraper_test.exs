defmodule ScraperTest do
  use ExUnit.Case
  doctest Scraper

  test "pulls the correct title" do
    data = Scraper.scrape_page("http://www.makersacademy.com")
    assert data.title == "Makers Academy"
  end

  test "creates tags" do
    data = Scraper.scrape_page("http://www.makersacademy.com")
    refute data.tags == ""
  end
end
