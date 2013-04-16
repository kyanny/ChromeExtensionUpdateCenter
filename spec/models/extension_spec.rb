require 'spec_helper'

describe Extension do
  describe '#store_binary_data' do
    context 'crx is present' do
      before do
        @extension = Extension.new(crx: open(fixture_files('hello.crx')))
      end

      it 'stores crx binary data' do
        @extension.store_binary_data
        expect(@extension.crx[0,4]).to eq("Cr24")
      end
    end

    context 'pem is present' do
      before do
        @extension = Extension.new(pem: open(fixture_files('hello.pem')))
      end

      it 'stores pem ascii data' do
        @extension.store_binary_data
        expect(@extension.pem).to match(/^-----BEGIN RSA PRIVATE KEY-----\n/)
      end
    end
  end

  describe '#unpack_crx' do
    before do
      @extension = Extension.new(crx: read_fixture_files('hello.crx'), pem: read_fixture_files('hello.pem'))
    end

    it "sets `name' from manifest.json" do
      expect {
        @extension.unpack_crx
      }.to change {
        @extension.name
      }.from(nil).to("Hello")
    end

    it "sets `version' from manifest.json" do
      expect {
        @extension.unpack_crx
      }.to change {
        @extension.version
      }.from(nil).to("1.0")
    end
  end

  describe '#calculate_appid' do
    before do
      @extension = Extension.new(crx: read_fixture_files('hello.crx'), pem: read_fixture_files('hello.pem'))
    end

    it "sets `appid' from pem" do
      expect {
        @extension.calculate_appid
      }.to change {
        @extension.appid
      }.from(nil).to("kifmmjimfiihjapngpjdcceapgijkjdo")
    end
  end

  describe '.latest_versions' do
    before do
      @h1 = FactoryGirl.create(:hello_extension)
      @h2 = FactoryGirl.create(:hello_extension, version: "2.0")
      @g1 = FactoryGirl.create(:goodbye_extension)
      @g2 = FactoryGirl.create(:goodbye_extension, version: "2.0")
    end

    it "returns latest version for each extensions" do
      expect(Extension.latest_versions.size).to eq(2)
      expect(Extension.latest_versions).to include(@h2)
      expect(Extension.latest_versions).to include(@g2)
    end
  end
end
