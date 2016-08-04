defmodule DelphiUrlSpec do
  use ESpec

	let :list do
		["http://www.test.com", "http://www.test.com/test", "http://www.test.com/all/test", "http://www.test.com/lulz", "http://www.test.com/hi/merve/yay/"]
	end

	before do
		allow(Delphi.Repo).to accept(:all, fn(a) -> list end)
	end

  it "searches url" do
		Delphi.Url.list
		expect(Delphi.Repo)
		|> to(accepted :all)
  end

end
