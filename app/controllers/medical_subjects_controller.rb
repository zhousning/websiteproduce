class MedicalSubjectsController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @medical_subject = MedicalSubject.first
    @majors = @medical_subject.medical_majors
  end
   

   

   

   

   

   

   
  def destroy
    @medical_subject = MedicalSubject.find(params[:id])
    @medical_subject.destroy
    redirect_to :action => :index
  end
   

  private
    def medical_subject_params
      params.require(:medical_subject).permit( :name, medical_majors_attributes: medical_major_params)
    end
  
  
    def medical_major_params
      [:id, :name]
    end
  
end

