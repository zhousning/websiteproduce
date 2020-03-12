class SubunitsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @subunits = Subunit.all
  end
   

   
  def show
    @subunit = Subunit.find(params[:id])
  end
   

   
  def new
    @subunit = Subunit.new
    
  end
   

   
  def create
    @subunit = Subunit.new(subunit_params)
    #@subunit.user = current_user
    if @subunit.save
      redirect_to @subunit
    else
      render :new
    end
  end
   

   
  def edit
    @subunit = Subunit.find(params[:id])
  end
   

   
  def update
    @subunit = Subunit.find(params[:id])
    if @subunit.update(subunit_params)
      redirect_to subunit_path(@subunit) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @subunit = Subunit.find(params[:id])
    @subunit.destroy
    redirect_to :action => :index
  end
   

  private
    def subunit_params
      params.require(:subunit).permit( :html, :css, :js, :name, :category, :tag, :icon_category, :min_length, :max_length)
    end
  
  
end

