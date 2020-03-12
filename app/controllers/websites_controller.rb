require 'fileutils'
require 'chinese_pinyin'

class WebsitesController < ApplicationController
  include TitlesHelper

  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource


  def export
    @website = Website.find(params[:id])
    @document = Document.new(:website => @website, :title => Time.now.to_i.to_s + "%04d" % [rand(10000)], :status => Setting.documents.status_none)
    if @document.save
      ExportWorker.perform_async(@website.id, @document.id)
      @document_id = @website.documents.size-1
      redirect_to website_document_path(@website, @document_id)
    else
      redirect_to :back
    end
  end

  def index
    @websites = current_user.websites 
  end

  def show
    @website = Website.find(params[:id])
    @pages = @website.pages
  end
   
  def new
    @website = Website.new
    index = Page.new(:name => '首页')
    pages = @website.pages << index 
    pages.build
    
  end
   

   
  def create
    @website = Website.new(website_params)
    @website.user = current_user
    if @website.save
      flash[:notice] = "保存成功"
      redirect_to edit_website_path(@website)
    else
      render :new
    end
  end
   

   
  def edit
    @website = Website.find(params[:id])
  end
   

   
  def update
    @website = Website.find(params[:id])
    if @website.update(website_params)
      flash[:notice] = "保存成功"
      redirect_to edit_website_path(@website) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @website = Website.find(params[:id])
    @website.destroy
    redirect_to :action => :index
  end
   

  private
    def website_params
      params.require(:website).permit( :name, :navbar, :logo, :mastheader, :footer, :style, :color , :phone, :wechat, :address, :email, :qq, :introduce, pages_attributes: page_params, navbars_attributes: navbar_params)
    end
  
    def page_params
      [:id, :name, :block_order]
    end
  
    def navbar_params
      [:id, :name]
    end
  
end

