require 'json'
require 'fileutils'
require 'nokogiri'

ROOT_PATH = 'lib/tasks/data/tiku/' 
OPTIONS_TAG = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N']

namespace 'db' do
  desc "import question"
  task(:import_questions => :environment) do
    add_questions
  end
end

def add_questions
  xy_linchuang = ROOT_PATH + '执业医师西医/理论/中心题库临床'
  xy_renwen = ROOT_PATH + '执业医师西医/理论/中心题库医学人文'
  xy_jichu = ROOT_PATH + '执业医师西医/理论/中心题库基础部分'
  
  zlxy_linchuang = ROOT_PATH + '助理医师西医/中心题库临床部分'
  zlxy_renwen = ROOT_PATH + '助理医师西医/中心题库医学人文'
  zlxy_jichu = ROOT_PATH + '助理医师西医/中心题库基础部分'

  zy_zhongxin = ROOT_PATH + '执业医师中医/中心题库'
  zyzl_zhongxin = ROOT_PATH + '助理医师中医/中心题库'
  
  objs = {
    '执业医师西医': [xy_linchuang, xy_renwen, xy_jichu],
    '执业医师中医': [zy_zhongxin],
    '助理医师西医': [zlxy_linchuang, zlxy_renwen, zlxy_jichu],
    '助理医师中医': [zyzl_zhongxin]
  }

  objs.each_pair do |k, v|
    @mdsubject = MedicalSubject.where(:name => k)
    if !@mdsubject.blank?
      v.each do |filepath|
        question_process(@mdsubject.first, filepath)
      end
    else
      @mdcsubject = MedicalSubject.create(:name => k) 
      v.each do |filepath|
        question_process(@mdcsubject, filepath)
      end
    end

  end

end

def question_process(subject, file_path)
  if File.directory? file_path
    Dir.foreach(file_path) do |file|
      path = file_path+"/"+file
      if file !="." and file !=".." && !File.directory?(path)
         json = File.read(path)
         obj = JSON.parse(json)
  
         obj['data'].each do |item|
           content = item['content']
           tagId = item['tagId']
           analysis = item['analysis']
           options = item['options']
           tags = item['tags']
  
           contentHtml = Nokogiri::HTML(content)
           analysisHtml = Nokogiri::HTML(analysis)
           major_name = ''
           answer = ''
           option_str = ''
           category = ''
           qst_type = ''
           
  
           tags.each do |t|
             if t['id'] == tagId
               major_name = t['name']
             end
           end

           mresult = major_name.match(/A1|A2|A3|B1|B2|B3/)
           qst_type = mresult.nil? ? 'other' : mresult[0]
  
           count = 0 
           options.each_with_index do |option, index|
             isTrue = option['isTrue']
             opt_html = Nokogiri::HTML(option['content'])

             if isTrue
               answer += OPTIONS_TAG[index] + ' ' 
               count += 1
             end
             option_str += OPTIONS_TAG[index] + opt_html.text + '   ' 
           end

           if count == 0
             category = Setting.medical_questions.category_other
           elsif count > 1
             category = Setting.medical_questions.category_multiple
           else
             category = Setting.medical_questions.category_single
           end

           @mdmajor = MedicalMajor.where(:name => major_name, :medical_subject => subject)
           if @mdmajor.blank?
             @mdcmajor = MedicalMajor.create(:name => major_name, :medical_subject => subject) 
             MedicalQuestion.create(:category => category, :title => contentHtml.text, :option => option_str, :answer => answer, :analysis => analysisHtml.text, :medical_major => @mdcmajor) 
           else
             MedicalQuestion.create(:category => category, :qst_type => qst_type, :title => contentHtml.text, :option => option_str, :answer => answer, :analysis => analysisHtml.text, :medical_major => @mdmajor.first) 
           end
         end
      end
    end
  end
end

#folder = file_path + "/" + "题库解析版/" 
#FileUtils.makedirs(folder) unless File.directory?(folder)
#
#target_file = folder + major_name + '.txt'
#File.open(target_file, 'a+') do|f|
#  result = contentHtml.text + "\r\n" +
#    option_str + "\r\n" +
#    '答案: ' + answer + "\r\n" +
#    '解析: ' + analysisHtml.text + "\r\n\r\n"
#  f.write(result)
#end 
