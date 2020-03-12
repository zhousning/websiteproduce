class TitleTwosController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @title_twos = TitleTwo.all
  end
   

   
  def show
    @title_two = TitleTwo.find(params[:id])
  end
   

   
  def new
    @title_two = TitleTwo.new
    
    @title_two.title_threes.build
    
  end
   

   
  def create
    @title_two = TitleTwo.new(title_two_params)
    #@title_two.user = current_user
    if @title_two.save
      redirect_to @title_two
    else
      render :new
    end
  end
   

   
  def edit
    @title_two = TitleTwo.find(params[:id])
  end
   

   
  def update
    @title_two = TitleTwo.find(params[:id])
    if @title_two.update(title_two_params)
      redirect_to title_two_path(@title_two) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @title_two = TitleTwo.find(params[:id])
    @title_two.destroy
    redirect_to :action => :index
  end
   

  private
    def title_two_params
      params.require(:title_two).permit( :tag, :align, :color, :font, :background, :weight, :line_height, :letter_spacing, title_threes_attributes: title_three_params)
    end
  
  
    def title_three_params
      [:id, :tag, :align, :color, :font, :background, :weight, :line_height, :letter_spacing]
    end
  
end

