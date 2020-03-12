require 'yaml'
require 'logger'

namespace 'db' do
  desc "export icon"
  task(:export_icons => :environment) do
    export_icons
  end
end

def export_icons
  #users = YAML.load_file("lib/tasks/users.yaml")
  @subunits = IconLibrary.all
  result = []
  @subunits.each do |s|
    hash = Hash.new
    hash['file_name'] = s.file_name
    hash['icon_type'] = s.icon_type
    result << hash
  end
  File.open(File.join(Rails.root, 'lib', 'tasks', 'icons.yaml'), 'a+') do |f|
    YAML.dump(result, f)
  end
end
