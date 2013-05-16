require 'spec_helper'

describe "tracks/index" do
  before(:each) do
    assign(:tracks, [
      stub_model(Track,
        :title => "Title",
        :track_file => "Track File"
      ),
      stub_model(Track,
        :title => "Title",
        :track_file => "Track File"
      )
    ])
  end

  it "renders a list of tracks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Track File".to_s, :count => 2
  end
end
