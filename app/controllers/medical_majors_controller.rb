class MedicalMajorsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  load_and_authorize_resource

   
  def index
    @medical_majors = MedicalMajor.all
  end
   

   

   

   

   

   

   
  def destroy
    @medical_major = MedicalMajor.find(params[:id])
    @medical_major.destroy
    redirect_to :action => :index
  end
   

  private
    def medical_major_params
      params.require(:medical_major).permit( :name, :total, medical_questions_attributes: medical_question_params)
    end
  
  
    def medical_question_params
      [:id, :]
    end
  
end

