class MedicalQuestionsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  load_and_authorize_resource

   
  def index
    @medical_questions = MedicalQuestion.all
  end
   

   

   

   

   

   

   
  def destroy
    @medical_question = MedicalQuestion.find(params[:id])
    @medical_question.destroy
    redirect_to :action => :index
  end
   

  private
    def medical_question_params
      params.require(:medical_question).permit( :title, :option, :answer, :analysis)
    end
  
  
end

