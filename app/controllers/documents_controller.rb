class DocumentsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @website = Website.find(params[:website_id])
    @documents = @website.documents
  end
   
   
  def show
    @website = Website.find(params[:website_id])
    documents = @website.documents
    @document_id = params[:id].to_i
    if @document_id >= 0 and @document_id <= documents.size-1
      @document = documents[@document_id]
      gon.websiteId = @website.id
      gon.documentId = @document_id
      gon.documentStatus = @document.status
    else
      redirect_to website_documents_path(@website)
    end
  end
   
  def download
    @website = Website.find(params[:website_id])
    documents = @website.documents
    @document_id = params[:id].to_i
    @document = documents[@document_id]
    if @document
      if params[:ft] == "html"
        send_file File.join(Rails.root, "public", "websites",  @document.html_link), :filename => @website.name + "网站", :type => "application/force-download", :x_sendfile=>true
      elsif params[:ft] == "erb"
        send_file File.join(Rails.root, "public", "erb_templates",  @document.erb_link), :filename => @website.name + "网站模板", :type => "application/force-download", :x_sendfile=>true
      else
        redirect_to website_document_path(@website, @document_id)
      end
    else
      redirect_to website_document_path(@website, @document_id)
    end
  end

  def check
    @website = Website.find(params[:website_id])
    @document_id = params[:id].to_i
    @document = @website.documents[@document_id]
    respond_to do |format|
      format.json{ render :json => 
        {
          :id=>@document_id,
          :title=>@document.title,
          :status=>@document.status
        }.to_json}
    end
  end

  private
    def document_params
      params.require(:document).permit( :title)
    end
  
  
end

