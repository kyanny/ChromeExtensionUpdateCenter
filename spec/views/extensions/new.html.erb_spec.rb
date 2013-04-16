require 'spec_helper'

describe "extensions/new" do
  before(:each) do
    assign(:extension, stub_model(Extension,
      :name => "MyString",
      :appid => "MyString",
      :pem => "",
      :crx => "",
      :version => "MyString",
      :release => false
    ).as_new_record)
  end

  it "renders new extension form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", extensions_path, "post" do
      assert_select "input#extension_name[name=?]", "extension[name]"
      assert_select "input#extension_appid[name=?]", "extension[appid]"
      assert_select "input#extension_pem[name=?]", "extension[pem]"
      assert_select "input#extension_crx[name=?]", "extension[crx]"
      assert_select "input#extension_version[name=?]", "extension[version]"
      assert_select "input#extension_release[name=?]", "extension[release]"
    end
  end
end
