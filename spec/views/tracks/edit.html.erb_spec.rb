require 'spec_helper'

describe "tracks/edit" do
  before(:each) do
    @track = assign(:track, stub_model(Track,
      :title => "MyString",
      :track_file => "MyString"
    ))
  end

  it "renders the edit track form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", track_path(@track), "post" do
      assert_select "input#track_title[name=?]", "track[title]"
      assert_select "input#track_track_file[name=?]", "track[track_file]"
    end
  end
end
