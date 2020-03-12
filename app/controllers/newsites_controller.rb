class NewsitesController < ApplicationController
  layout "application"
  before_filter :authenticate_user!

  def index
  end

  def new
    @website = Website.new
    index = Page.new(:name => '首页')
    pages = @website.pages << index 
    pages.build
  end

  def edit
    @website = Website.find(params[:id])
  end

  def create
    @website = Website.new(website_params)
    @website.user = current_user
    if @website.save
      redirect_to draft_navbar_newsite_path(@website)
    else
      render :new
    end
  end

  def update
    @website = Website.find(params[:id])
    if @website.update(website_params)
      redirect_to draft_navbar_newsite_path(@website)
    else
      render :edit
    end
  end

  def draft_navbar
    @website = Website.find(params[:id])
    @pages = @website.pages
    gon.id = @website.id
    @menus = [] 
    @pages.each do |page|
      @menus << page if page.parent_id.nil?
    end
  end

  def draft_edit
    @website = Website.find(params[:id])
    @pages = @website.pages
    gon.draftid = @website.id
    render :layout => "application_no_header"
  end

  def draft_update
    @website = Website.find(params[:id])
    if @website.update(website_params)
      redirect_to draft_edit_newsite_path(@website)
    else
      render :draft_edit
    end
  end

  def preview
    @website = Website.find(params[:id])
  end

  def prepare
    @website = Website.find(params[:id])
    gon.newsiteid = @website.id
  end

  def produce
    @website = Website.find(params[:id])
    deploy_component(@website)
    @document = Document.new(:website => @website, :title => Time.now.to_i.to_s + "%04d" % [rand(10000)], :status => Setting.documents.status_none)
    if @document.save
      ExportWorker.perform_async(@website.id, @document.id)
      @document_id = @website.documents.size-1
      redirect_to website_document_path(@website, @document_id)
    else
      redirect_to :back
    end
  end

  def format_text(text)
    text.gsub("&nbsp;", " ").gsub("\t", "").gsub("\n", "")
  end

  def deploy_component(website)
    navbar = Subunit.where(:category => Setting.subunit_types.navbar.value).sample(1)[0]
    footer = Subunit.where(:category => Setting.subunit_types.footer.value).sample(1)[0]
    mastheader = Subunit.where(:category => Setting.subunit_types.mastheader.value).sample(1)[0]

    website.add_navbar(navbar.id)
    website.add_footer(footer.id)

    website.pages.each do |page|
      page.add_mastheader(mastheader.id)
      page.blocks.each do |block|
        contents = block.block_contents
        size = contents.size
        section = nil
        if size > 0
          content_size = 0
          contents.each do |content|
            content_size += content.description.length
          end
          section = deploy_section(content_size%size)
        else
          section = deploy_section(-1) #只有一级标题二级标题的情况
        end
        block.add_subunit(section.id)
      end
    end
  end

  def deploy_section(content_size)
    section = Subunit.where(["category = ? and min_length <= ? and max_length >= ?", Setting.subunit_types.section.value, content_size, content_size]).sample(1)[0]
    section
  end

  #def draft_update
  #  pages = params[:pages]
  #  begin
  #    Page.transaction do 
  #      pages.each do |key, value|
  #        @page = Page.find(value['id'])
  #        @page.update_attributes!(:draft => value['content'] )
  #      end
  #    end

  #    respond_to do |f|
  #      f.json { render :json => {:state => 'success'}.to_json }
  #    end
  #  rescue
  #    respond_to do |f|
  #      f.json { render :json => {:state => 'error'}.to_json }
  #    end
  #  end
  #end

  private
    def website_params
      params.require(:website).permit( :name, :navbar, :logo, :mastheader, :footer, :style, :color , :phone, :wechat, :address, :email, :qq, :introduce, pages_attributes: page_params)
    end
  
  
    def page_params
      [:id, :name, :block_order, :draft, enclosures_attributes: enclosure_params, blocks_attributes: block_params]
    end

    def block_params
      [:id,:title, :title_two, :background, :color, :block_layout, :subunit, :reset_icon, block_contents_attributes: block_content_params]
    end

    def block_content_params
      [:id, :title, :description, enclosures_attributes: enclosure_params]
    end

    def enclosure_params
      [:id, :file, :_destroy]
    end
  
end
  #使用富文本编辑器做没实现解析功能,暂时先不用了
  #@pages = produce_page_block(@website)
  #@pages.each do |page_blocks|
  #  page_blocks.each do |block|
  #    puts block.block_contents.size
  #  end
  #end
  #def produce_page_block(website)
  #  pages = []
  #  website.pages.each do |page|
  #    draft = page.draft
  #    doc = Nokogiri::HTML(draft)
  #    items = doc.css('body').children
  #    block_arr = []
  #    items.each do |item|
  #      next if item == "\n"
  #      next if item.name == "text" #没有标签包裹
  #      if item.name == 'h1'
  #        @content_arr = []
  #        @block = Block.new(:title => item.text)
  #        @block.block_contents << @content_arr 
  #        block_arr << @block
  #      elsif item.name == 'h2'
  #        @block.title_two = item.text
  #      elsif item.name == 'h3'
  #        @block_content = BlockContent.new(:title => item.text)
  #        @content_arr << @block_content
  #      elsif item.name == 'p'
  #        @block_content.description = item.text
  #      end
  #    end
  #    pages << block_arr
  #  end
  #  pages
  #end

