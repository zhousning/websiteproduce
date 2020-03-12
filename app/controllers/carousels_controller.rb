class CarouselsController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @carousels = Carousel.all
  end
   

   
  def show
    @carousel = Carousel.find(params[:id])
  end
   

   
  def new
    @carousel = Carousel.new
    
  end
   

   
  def create
    @carousel = Carousel.new(carousel_params)
    #@carousel.user = current_user
    if @carousel.save
      redirect_to @carousel
    else
      render :new
    end
  end
   

   
  def edit
    @carousel = Carousel.find(params[:id])
  end
   

   
  def update
    @carousel = Carousel.find(params[:id])
    if @carousel.update(carousel_params)
      redirect_to carousel_path(@carousel) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @carousel = Carousel.find(params[:id])
    @carousel.destroy
    redirect_to :action => :index
  end
   

  private
    def carousel_params
      params.require(:carousel).permit( :name , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
end

