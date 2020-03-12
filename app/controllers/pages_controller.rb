class PagesController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @website = Website.find(params[:website_id])
    @pages = @website.pages 
    gon.id = @website.id
    @menus = [] 
    @pages.each do |page|
      @menus << page if page.parent_id.nil?
    end
  end
   

   
  def show
    @website = Website.find(params[:website_id])
    pages = @website.pages
    @page_id = params[:id].to_i
    if @page_id >= 0 and @page_id <= pages.size-1
      @page = pages[@page_id]
    else
      redirect_to website_pages_path(@website)
    end
  end
   

   
  def new
    @page = Page.new
    
    @page.blocks.build
    
    @page.carousels.build
    
  end
   

   
  def create
    @page = Page.new(page_params)
    #@page.user = current_user
    if @page.save
      redirect_to @page
    else
      render :new
    end
  end
   

   
  def edit
    @website = Website.find(params[:website_id])
    pages = @website.pages
    @page_id = params[:id].to_i
    if @page_id >= 0 and @page_id <= pages.size-1
      @page = pages[@page_id]
    else
      redirect_to website_pages_path(@website)
    end
  end
   

   
  def update
    @website = Website.find(params[:website_id])
    pages = @website.pages
    @page_id = params[:id].to_i
    @page = pages[@page_id]
    if @page.update(page_params)
      redirect_to website_page_path(@website, @page_id) 
    else
      render :edit
    end
  end
   

  def set_parent
    @website = current_user.websites.where(:id => params[:website_id])[0]
    @page = @website.pages.where(:id => params[:id])[0]
    if @website.nil? || @page.nil?
      respond_to do |f|
        f.json { render :json => {:state => 'param_error'}.to_json } 
      end
      return
    end

    unless params[:parent_id].blank?
      parent_page = Page.find(params[:parent_id])
      if parent_page.parent && parent_page.parent.id == params[:id].to_i
        respond_to do |f|
          f.json { render :json => {:state => 'repeat'}.to_json } 
        end
        return
      end
    end
    if @page.update_attribute(:parent_id, params[:parent_id])
      @pages = @website.pages.where(:parent_id => nil)
      result = []
      @pages.each do |page|
        data = Hash.new
        data['key'] = page.name
        data['value'] = page.id
        arr = []
        page.children.each do |c|
          arr << c.name
        end
        data['child'] = arr
        result << data
      end
      respond_to do |f|
        f.json { render :json => {:state => 'success', :data => result}.to_json } 
      end
    else
      respond_to do |f|
        f.json { render :json => {:state => 'fail'}.to_json } 
      end
    end
  end
   
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to :action => :index
  end
   

  private
    def page_params
      params.require(:page).permit( :name, :mastheader, :block_order , enclosures_attributes: enclosure_params, blocks_attributes: block_params, carousels_attributes: carousel_params)
    end
  
    def block_params
      [:id,:title, :title_two, :background, :color, :block_layout, :subunit, :reset_icon, block_contents_attributes: block_content_params]
    end

    def block_content_params
      [:id, :title, :file, :description]
    end

    def carousel_params
      [:id, :name, :file]
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
end

