class ColorLibrariesController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @color_libraries = ColorLibrary.all
  end
   

   
  def show
    @color_library = ColorLibrary.find(params[:id])
  end
   

   
  def new
    @color_library = ColorLibrary.new
    
  end
   

   
  def create
    @color_library = ColorLibrary.new(color_library_params)
    #@color_library.user = current_user
    if @color_library.save
      redirect_to @color_library
    else
      render :new
    end
  end
   

   
  def edit
    @color_library = ColorLibrary.find(params[:id])
  end
   

   
  def update
    @color_library = ColorLibrary.find(params[:id])
    if @color_library.update(color_library_params)
      redirect_to color_library_path(@color_library) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @color_library = ColorLibrary.find(params[:id])
    @color_library.destroy
    redirect_to :action => :index
  end
   

  private
    def color_library_params
      params.require(:color_library).permit( :category, :style, :color_value, :tag)
    end
  
  
end

