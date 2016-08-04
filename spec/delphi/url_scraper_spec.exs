defmodule UrlScraperSpec do
  use ESpec

  it "searches url" do
		expect UrlScraper.search_urls("http://www.makersacademy.com")
		|> to(have_first "http://www.makersacademy.com/graduates")
  end

end
