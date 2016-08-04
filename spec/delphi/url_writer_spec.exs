defmodule UrlWriterSpec do
  use ESpec

  let :list do
    ["http://www.test.com", "http://www.test.com/test", "http://www.test.com/all/test", "http://www.test.com/lulz", "http://www.test.com/hi/merve/yay/"]
  end

  before do
    allow(UrlScraper).to accept(:search_urls, fn(a) -> list end)
    allow(ScraperController).to accept(:scrape_page, fn(a) -> :ok end)
    allow(Delphi.Repo).to accept(:insert, fn(a) -> {:ok, "it worked"} end)
  end

  it "adds a url to the table" do
    UrlWriter.add_url_to_table("http://www.test.com")
    expect(Delphi.Repo)
    |> to(accepted :insert)
  end

end
