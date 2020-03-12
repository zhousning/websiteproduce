class ImageLibrariesController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  load_and_authorize_resource

   
  def index
    @image_libraries = ImageLibrary.all
  end
   

   
  def show
    @image_library = ImageLibrary.find(params[:id])
  end
   

   
  def new
    @image_library = ImageLibrary.new
    
  end
   

   
  def create
    @image_library = ImageLibrary.new(image_library_params)
    #@image_library.user = current_user
    if @image_library.save
      redirect_to @image_library
    else
      render :new
    end
  end
   

   
  def edit
    @image_library = ImageLibrary.find(params[:id])
  end
   

   
  def update
    @image_library = ImageLibrary.find(params[:id])
    if @image_library.update(image_library_params)
      redirect_to image_library_path(@image_library) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @image_library = ImageLibrary.find(params[:id])
    @image_library.destroy
    redirect_to :action => :index
  end
   

  private
    def image_library_params
      params.require(:image_library).permit( :category, :style, :file_name, :width, :height, :tag)
    end
  
  
end

