require 'yaml'
require 'logger'
require 'find'

namespace 'db' do
  desc "init user"
  task(:create_icon_library => :environment) do
    init_add 
  end
end


def init_add
  fontawesomes = YAML.load_file("lib/tasks/data/fontawesome-title.yml")
  fontawesomes.each do |font|
    icon = IconLibrary.where(:file_name => font)
    IconLibrary.create(:file_name => font) if icon.blank?
  end
end


#以下是使用百度ai分类的文件夹的图标,暂时不用了
def init_icon_add
  categories = Setting.icon_category
  categories.values.each do |ctg|
    ctg_dir = File.join(Rails.root, "public", "icon_library", ctg)
    Find.find(ctg_dir) do |target|
      result = target.match(/\/([^\/]+)\/([^\/]+)\/([^\/]+)\/([^\/]+)\/([^\/]+\.png)$/)
      if result
        category = result[1]
        scene = result[2]
        style = result[3]
        file_name = result[5]
        puts category + "  " + scene + " " + style + "  " + file_name
        icon = IconLibrary.where(:category => category, :scene => scene, :style => style, :file_name => file_name)
        IconLibrary.create(:category => category, :scene => scene, :style => style, :file_name => file_name) if icon.blank?
      end
    end
    #if File.directory? ctg_dir 
    #  Dir.foreach(ctg_dir) do |scene_dir|
    #    puts File.basename(scene_dir)
    #  end
    #end
  end
end

def create_category
  categories = Setting.icon_category
  categories.values.each do |ctg|
    dir = File.join(Rails.root, "public", "icon_library", ctg)
    Dir::mkdir(dir) unless File.directory?(dir)
  end
end
