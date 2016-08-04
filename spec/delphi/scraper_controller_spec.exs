defmodule UrlScraperControllerSpec do
  use ESpec

	let :test_map do
		%{title: "Title", description: "Description", url: "http://www.test.com"}
	end

	before do
		allow(Delphi.Repo).to accept(:insert, fn(a) -> {:ok, "it worked"} end)
		allow(Scrape).to accept(:website, fn(a) -> test_map end)
	end

  it "searches url" do
		ScraperController.scrape_page("http://www.test.com")
		expect(Delphi.Repo)
		|> to(accepted :insert)
		expect(Scrape)
		|> to(accepted :website)
  end

end
