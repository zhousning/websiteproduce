class NavbarsController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @navbars = Navbar.all
  end
   

   
  def show
    @navbar = Navbar.find(params[:id])
  end
   

   
  def new
    @navbar = Navbar.new
    
    @navbar.menus.build
    
  end
   

   
  def create
    @navbar = Navbar.new(navbar_params)
    #@navbar.user = current_user
    if @navbar.save
      redirect_to @navbar
    else
      render :new
    end
  end
   

   
  def edit
    @navbar = Navbar.find(params[:id])
  end
   

   
  def update
    @navbar = Navbar.find(params[:id])
    if @navbar.update(navbar_params)
      redirect_to navbar_path(@navbar) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @navbar = Navbar.find(params[:id])
    @navbar.destroy
    redirect_to :action => :index
  end
   

  private
    def navbar_params
      params.require(:navbar).permit( :name, menus_attributes: menu_params)
    end
  
  
    def menu_params
      [:id]
    end
  
end

