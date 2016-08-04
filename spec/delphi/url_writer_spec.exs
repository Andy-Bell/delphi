defmodule UrlWriterSpec do
  use ESpec

  before do
    allow(UrlScraper).to accept(:search_urls, fn(a) -> list end)
    allow(UrlWriter).to accept(:write, fn(a) -> :ok end)
    allow(ScraperController).to accept(:scrape_page, fn(a) -> :ok end)
  end

  let :list do
    ["http://www.test.com", "http://www.test.com/test", "http://www.test.com/all/test", "http://www.test.com/lulz", "http://www.test.com/hi/merve/yay/"]
  end

  it "adds a url to the table" do
    expect UrlWriter.add_url_to_table("http://www.test.com")
    |> to(eq :ok )
    expect UrlWriter |> to(accepted :)
  end

end