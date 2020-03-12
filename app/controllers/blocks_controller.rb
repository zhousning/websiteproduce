class BlocksController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @blocks = Block.all
  end
   

   
  def show
    @block = Block.find(params[:id])
  end
   

   
  def new
    @block = Block.new
    
    @block.block_contents.build
    
  end
   

   
  def create
    @block = Block.new(block_params)
    #@block.user = current_user
    if @block.save
      redirect_to @block
    else
      render :new
    end
  end
   

   
  def edit
    @block = Block.find(params[:id])
  end
   

   
  def update
    @block = Block.find(params[:id])
    if @block.update(block_params)
      redirect_to block_path(@block) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to :action => :index
  end
   

  private
    def block_params
      params.require(:block).permit( :name, :layout, :subunit, :background, block_contents_attributes: block_content_params)
    end
  
  
    def block_content_params
      [:id, :description, enclosures_attributes: enclosure_params]
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
end

