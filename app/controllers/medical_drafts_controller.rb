class MedicalDraftsController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #load_and_authorize_resource
  
   
  def index
    @medical_drafts = MedicalDraft.all
  end
   

   
  def show
    @medical_draft = MedicalDraft.find(params[:id])
  end
   

   
  def new
    @medical_draft = MedicalDraft.new
    
    #@medical_draft.medical_majors.build
    
  end
   

   
  def create
    @medical_draft = MedicalDraft.new(medical_draft_params)
    #@medical_draft.user = current_user
    if @medical_draft.save
      redirect_to @medical_draft
    else
      render :new
    end
  end
   

   
  def edit
    @medical_draft = MedicalDraft.find(params[:id])
    @medical_subject = MedicalSubject.first
    @majors = @medical_subject.medical_majors

    @dftmajors = Hash.new
    @draft_majors = @medical_draft.draft_majors
    @draft_majors.each do |m|
      @dftmajors[m.medical_major_id.to_s] = m.total 
    end

    @A1s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.a1 + "%").order("name ASC") 
    @A2s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.a2 + "%").order("name ASC") 
    @A3s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.a3 + "%").order("name ASC") 
    @B1s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.b1 + "%").order("name ASC") 
    @B2s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.b2 + "%").order("name ASC") 
    @B3s = @majors.where("name LIKE ?", "%"+ Setting.medical_questions.b3 + "%").order("name ASC") 
    @others = @majors.where("name LIKE ?", "%" + Setting.medical_questions.other + "%").order("name ASC") 
  end
   

   
  def update
    @medical_draft = MedicalDraft.find(params[:id])
    majors = params["major"]
    @medical_draft.medical_majors.destroy_all
    majors.each_pair do |k, v|
      if !v.blank? && v != 0
        DraftMajor.create(
          :medical_draft_id => @medical_draft.id,
          :medical_major_id => k,
          :total => v)
      end
    end
    if @medical_draft.update(medical_draft_params)
      redirect_to medical_draft_path(@medical_draft) 
    else
      render :edit
    end
  end

  def organize
    @medical_draft = MedicalDraft.find(params[:id])
    @dfmajors = @medical_draft.draft_majors

    paper_folder = File.join(Rails.root, "public", "papers", @medical_draft.name) + "/"
    FileUtils.makedirs(paper_folder) unless File.directory?(paper_folder)

    @dfmajors.each do |dfm|
      major_id = dfm.medical_major_id
      total = dfm.total*Setting.medical_questions.paper_total
      @major = MedicalMajor.find(major_id)
      name = @major.name
      @questions = @major.medical_questions.sample(total).each_slice(dfm.total)


      @questions.each_with_index do |qsts, index|
        index = index + 1
        puts index
        result = ''
        analysis = ''
        qsts.each do |q|
          result += q.title + "\r\n" +
            q.option + "\r\n\r\n"
          analysis += 
            '答案: ' + q.answer + "\r\n" +
            '解析: ' + q.analysis + "\r\n\r\n"
        end

        target_file = paper_folder + '试卷'
        analysis_file = paper_folder + '试卷'
        if name.match(/A1/) 
          target_file += index.to_s + 'A1.txt'
          analysis_file += index.to_s + 'A1解析.txt'
        elsif name.match(/A2/) 
          target_file += index.to_s + 'A2.txt'
          analysis_file += index.to_s + 'A2解析.txt'
        elsif name.match(/A3/) 
          target_file += index.to_s + 'A3.txt'
          analysis_file += index.to_s + 'A3解析.txt'
        elsif name.match(/B1/) 
          target_file += index.to_s + 'B1.txt'
          analysis_file += index.to_s + 'B1解析.txt'
        end

        File.open(target_file, 'a+') do|f|
          f.write(result)
        end 
        File.open(analysis_file, 'a+') do|f|
          f.write(analysis)
        end 
      end
    end

    redirect_to medical_drafts_url

  end
   

   
  def destroy
    @medical_draft = MedicalDraft.find(params[:id])
    @medical_draft.destroy
    redirect_to :action => :index
  end
   

  private
    def medical_draft_params
      params.require(:medical_draft).permit( :name, medical_majors_attributes: medical_major_params)
    end
  
  
    def medical_major_params
      [:id, :name]
    end
  
end

