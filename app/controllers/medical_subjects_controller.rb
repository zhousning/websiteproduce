class MedicalSubjectsController < ApplicationController
  #layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @medical_subject = MedicalSubject.first
    @majors = @medical_subject.medical_majors

    @A1s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.a1 + "%").order("name ASC") 
    @A2s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.a2 + "%").order("name ASC") 
    @A3s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.a3 + "%").order("name ASC") 
    @B1s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.b1 + "%").order("name ASC") 
    @B2s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.b2 + "%").order("name ASC") 
    @B3s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.b3 + "%").order("name ASC") 
    @others = @majors.where("name LIKE ?", "%" + Setting.medical_questions.other + "%").order("name ASC") 
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

