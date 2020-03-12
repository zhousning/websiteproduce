require 'yaml'
require 'logger'

namespace 'db' do
  desc "export subunit"
  task(:export_subunits => :environment) do
    init_export
  end
end

def init_export
  #users = YAML.load_file("lib/tasks/users.yaml")
  @subunits = Subunit.all
  result = []
  @subunits.each do |s|
    hash = Hash.new
    hash['html'] = s.html
    hash['css'] = s.css
    hash['js'] = s.js
    hash['name'] = s.name
    hash['tag'] = s.tag
    hash['category'] = s.category
    hash['icon_category'] = s.icon_category
    hash['min_length'] = s.min_length
    hash['max_length'] = s.max_length
    result << hash
    File.open(File.join(Rails.root, 'lib', 'tasks', 'subunits.yaml'), 'a+') do |f|
      YAML.dump(result, f)
    end
  end
end
