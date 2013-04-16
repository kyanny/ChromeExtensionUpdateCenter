require 'spec_helper'

describe ExtensionsController do

  describe "GET index" do
    before do
      @hello_extension = FactoryGirl.create(:hello_extension)
      @goodbye_extension = FactoryGirl.create(:goodbye_extension)
    end

    it "assigns all extensions as @extensions" do
      get :index, {}
      assigns(:extensions).should eq([@hello_extension, @goodbye_extension])
    end
  end

  describe "GET show" do
    before do
      @extension = FactoryGirl.create(:hello_extension)
    end

    it "assigns the requested extension as @extension" do
      get :show, {:id => @extension.to_param}
      assigns(:extension).should eq(@extension)
    end
  end

  describe "GET new" do
    it "assigns a new extension as @extension" do
      get :new, {}
      assigns(:extension).should be_a_new(Extension)
    end
  end

  describe "GET edit" do
    before do
      @extension = FactoryGirl.create(:hello_extension)
    end

    it "assigns the requested extension as @extension" do
      get :edit, {:id => @extension.to_param}
      assigns(:extension).should eq(@extension)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Extension" do
        expect {
          post :create, {
            :extension => {
              crx: fixture_file_upload('/extensions/hello.crx'),
              pem: fixture_file_upload('/extensions/hello.pem'),
              release: true
            }
          }
        }.to change(Extension, :count).by(1)
      end

      it "assigns a newly created extension as @extension" do
        post :create, {
          :extension => {
            crx: fixture_file_upload('/extensions/hello.crx'),
            pem: fixture_file_upload('/extensions/hello.pem'),
            release: true
          }
        }
        assigns(:extension).should be_a(Extension)
        assigns(:extension).should be_persisted
      end

      it "redirects to the created extension" do
        post :create, {
          :extension => {
            crx: fixture_file_upload('/extensions/hello.crx'),
            pem: fixture_file_upload('/extensions/hello.pem'),
            release: true
          }
        }
        response.should redirect_to(Extension.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved extension as @extension" do
        Extension.any_instance.stub(:save).and_return(false)
        post :create, {:extension => { "name" => "invalid value" }}
        assigns(:extension).should be_a_new(Extension)
      end

      it "re-renders the 'new' template" do
        Extension.any_instance.stub(:save).and_return(false)
        post :create, {:extension => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before do
        @extension = FactoryGirl.create(:hello_extension)
      end

      it "updates the requested extension" do
        Extension.any_instance.should_receive(:update_attributes).with({ "release" => false })
        put :update, {:id => @extension.to_param, :extension => { "release" => false }}
      end

      it "assigns the requested extension as @extension" do
        put :update, {:id => @extension.to_param, :extension => { "release" => false }}
        assigns(:extension).should eq(@extension)
      end

      it "redirects to the extension" do
        put :update, {:id => @extension.to_param, :extension => { "release" => false }}
        response.should redirect_to(@extension)
      end
    end

    describe "with invalid params" do
      before do
        @extension = FactoryGirl.create(:hello_extension)
      end

      it "assigns the extension as @extension" do
        Extension.any_instance.stub(:save).and_return(false)
        put :update, {:id => @extension.to_param, :extension => { "release" => false }}
        assigns(:extension).should eq(@extension)
      end

      it "re-renders the 'edit' template" do
        Extension.any_instance.stub(:save).and_return(false)
        put :update, {:id => @extension.to_param, :extension => { "release" => false }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @extension = FactoryGirl.create(:hello_extension)
    end

    it "destroys the requested extension" do
      expect {
        delete :destroy, {:id => @extension.to_param}
      }.to change(Extension, :count).by(-1)
    end

    it "redirects to the extensions list" do
      delete :destroy, {:id => @extension.to_param}
      response.should redirect_to(extensions_url)
    end
  end

end
