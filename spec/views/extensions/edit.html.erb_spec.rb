require 'spec_helper'

describe "extensions/edit" do
  before(:each) do
    @extension = assign(:extension, stub_model(Extension,
      :name => "MyString",
      :appid => "MyString",
      :pem => "",
      :crx => "",
      :version => "MyString",
      :release => false
    ))
  end

  it "renders the edit extension form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", extension_path(@extension), "post" do
      assert_select "input#extension_name[name=?]", "extension[name]"
      assert_select "input#extension_appid[name=?]", "extension[appid]"
      assert_select "input#extension_pem[name=?]", "extension[pem]"
      assert_select "input#extension_crx[name=?]", "extension[crx]"
      assert_select "input#extension_version[name=?]", "extension[version]"
      assert_select "input#extension_release[name=?]", "extension[release]"
    end
  end
end
