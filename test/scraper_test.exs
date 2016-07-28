defmodule ScraperTest do
  use ExUnit.Case
  doctest ScraperController

  test "pulls the correct title" do
    data = ScraperController.scrape_page("http://www.makersacademy.com")
    assert data.title == "Makers Academy"
  end

  test "creates tags" do
    data = ScraperController.scrape_page("http://www.makersacademy.com")
    refute data.tags == ""
  end
end
