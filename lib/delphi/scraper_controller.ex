defmodule ScraperController do

  def scrape_page(url) do
    Scrape.article url
    # |> article_filter
    # |> database_insert(conn, table)
    UrlScraper.search_urls url
    # |> url_filter
    # |> database_insert(conn, table2)

  end

end
