class FormatsController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @formats = Format.all
  end
   

   
  def show
    @format = Format.find(params[:id])
  end
   

   
  def new
    @format = Format.new
    
  end
   

   
  def create
    @format = Format.new(format_params)
    #@format.user = current_user
    if @format.save
      redirect_to @format
    else
      render :new
    end
  end
   

   
  def edit
    @format = Format.find(params[:id])
  end
   

   
  def update
    @format = Format.find(params[:id])
    if @format.update(format_params)
      redirect_to format_path(@format) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @format = Format.find(params[:id])
    @format.destroy
    redirect_to :action => :index
  end
   

  private
    def format_params
      params.require(:format).permit( :name , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
end

