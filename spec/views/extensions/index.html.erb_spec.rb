require 'spec_helper'

describe "extensions/index" do
  before(:each) do
    assign(:extensions, [
      stub_model(Extension,
        :name => "Name",
        :appid => "Appid",
        :pem => "",
        :crx => "",
        :version => "Version",
        :release => false
      ),
      stub_model(Extension,
        :name => "Name",
        :appid => "Appid",
        :pem => "",
        :crx => "",
        :version => "Version",
        :release => false
      )
    ])
  end

  it "renders a list of extensions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Appid".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Version".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
