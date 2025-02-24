require "spec_helper"

describe "layouts/application.html.erb" do
  let!(:search) { { path: cookbooks_path, name: "Cookbooks" } }

  before :each do
    ENV["ANNOUNCEMENT_TEXT"] = "supermarket announcement text"
    ENV["ANNOUNCEMENT_BANNER"] = "true"
    assign(:search, search)

    allow(view).to receive(:search).and_return(search)
    allow(view).to receive(:signed_in?).and_return(false)
    allow(Feature).to receive(:active).with(:announcement).and_return(true)
  end

  it "renders banner when env variable is there" do
    render
    expect(rendered).to include("supermarket announcement text")
  end

  it "does not render banner when flag is false" do
    ENV["ANNOUNCEMENT_BANNER"] = "false"
    render
    expect(rendered).not_to include("supermarket announcement text")
  end
end
