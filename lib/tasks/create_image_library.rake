require 'yaml'
require 'logger'
require 'find'

namespace 'db' do
  desc "init color"
  task(:create_image_library => :environment) do
    add_images 
  end
end


def add_images
  images = YAML.load_file('lib/tasks/data/pure_images.yml')
  images.each do |obj|
    path = obj['path']
    root = obj['root'].split("-").uniq.join(",")
    keyword = obj['keyword']
    width = obj['width']
    height = obj['height']
    ImageLibrary.create(:style => Setting.website_styles.pure.value, :file_name => path, :width => width, :height => height, :tag => root + keyword)
  end
end

