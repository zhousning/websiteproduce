class TitleThreesController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @title_threes = TitleThree.all
  end
   

   
  def show
    @title_three = TitleThree.find(params[:id])
  end
   

   
  def new
    @title_three = TitleThree.new
    
  end
   

   
  def create
    @title_three = TitleThree.new(title_three_params)
    #@title_three.user = current_user
    if @title_three.save
      redirect_to @title_three
    else
      render :new
    end
  end
   

   
  def edit
    @title_three = TitleThree.find(params[:id])
  end
   

   
  def update
    @title_three = TitleThree.find(params[:id])
    if @title_three.update(title_three_params)
      redirect_to title_three_path(@title_three) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @title_three = TitleThree.find(params[:id])
    @title_three.destroy
    redirect_to :action => :index
  end
   

  private
    def title_three_params
      params.require(:title_three).permit( :tag, :align, :color, :font, :background, :weight, :line_height, :letter_spacing)
    end
  
  
end

