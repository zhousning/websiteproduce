class TitleOnesController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @title_ones = TitleOne.all
  end
   

   
  def show
    @title_one = TitleOne.find(params[:id])
  end
   

   
  def new
    @title_one = TitleOne.new
    
    @title_twos = @title_one.title_twos.build

    @title_twos.title_threes.build 
  end
   

   
  def create
    @title_one = TitleOne.new(title_one_params)
    #@title_one.user = current_user
    if @title_one.save
      redirect_to @title_one
    else
      render :new
    end
  end
   

   
  def edit
    @title_one = TitleOne.find(params[:id])
  end
   

   
  def update
    @title_one = TitleOne.find(params[:id])
    if @title_one.update(title_one_params)
      redirect_to title_one_path(@title_one) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @title_one = TitleOne.find(params[:id])
    @title_one.destroy
    redirect_to :action => :index
  end
   

  private
    def title_one_params
      params.require(:title_one).permit( :tag, :align, :color, :weight, :font, :background, :line_height, :letter_spacing, title_twos_attributes: title_two_params)
    end
  
  
    def title_two_params
      [:id, :tag, :align, :color, :font, :background, :weight, :line_height, :letter_spacing, title_threes_attributes: title_three_params]
    end
  
    def title_three_params
      [:id, :tag, :align, :color, :font, :background, :weight, :line_height, :letter_spacing]
    end
end

