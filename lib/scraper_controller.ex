defmodule ScraperController do

  def scrape_page(url) do
    Scrape.article url
  end

end
