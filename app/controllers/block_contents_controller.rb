class BlockContentsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @block_contents = BlockContent.all
  end
   

   
  def show
    @block_content = BlockContent.find(params[:id])
  end
   

   
  def new
    @block_content = BlockContent.new
    
  end
   

   
  def create
    @block_content = BlockContent.new(block_content_params)
    #@block_content.user = current_user
    if @block_content.save
      redirect_to @block_content
    else
      render :new
    end
  end
   

   
  def edit
    @block_content = BlockContent.find(params[:id])
  end
   

   
  def update
    @block_content = BlockContent.find(params[:id])
    if @block_content.update(block_content_params)
      redirect_to block_content_path(@block_content) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @block_content = BlockContent.find(params[:id])
    @block_content.destroy
    redirect_to :action => :index
  end
   

  private
    def block_content_params
      params.require(:block_content).permit(:title, :description , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
end

