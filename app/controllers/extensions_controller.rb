class ExtensionsController < ApplicationController
  respond_to :html, :json

  def index
    @extensions = Extension.all
    respond_with @extensions
  end

  def show
    @extension = Extension.find(params[:id])
    respond_with @extension
  end

  def new
    @extension = Extension.new
    respond_with @extension
  end

  def edit
    @extension = Extension.find(params[:id])
  end

  def create
    @extension = Extension.new(params[:extension])
    @extension.store_binary_data
    @extension.unpack_crx
    @extension.calculate_appid

    respond_to do |format|
      if @extension.save
        format.html { redirect_to @extension, notice: 'Extension was successfully created.' }
        format.json { render json: @extension, status: :created, location: @extension }
      else
        format.html { render action: "new" }
        format.json { render json: @extension.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @extension = Extension.find(params[:id])

    respond_to do |format|
      if @extension.update_attributes(params[:extension])
        format.html { redirect_to @extension, notice: 'Extension was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @extension.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @extension = Extension.find(params[:id])
    @extension.destroy

    respond_to do |format|
      format.html { redirect_to extensions_url }
      format.json { head :no_content }
    end
  end

  def updates
    @extensions = Extension.latest_versions
    respond_to do |format|
      format.xml { render }
    end
  end

  def crx
    extension = Extension.find(params[:id])

    if extension.version != params[:v]
      render text: "Invalid version parameter", status: 403
    end

    send_data extension.crx, type: 'application/x-chrome-extension', filename: extension.appid + ".crx", disposition: :inline
  end
end
