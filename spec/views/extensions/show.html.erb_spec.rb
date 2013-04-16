require 'spec_helper'

describe "extensions/show" do
  before(:each) do
    @extension = assign(:extension, stub_model(Extension,
      :name => "Name",
      :appid => "Appid",
      :pem => "",
      :crx => "",
      :version => "Version",
      :release => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Appid/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Version/)
    rendered.should match(/false/)
  end
end
