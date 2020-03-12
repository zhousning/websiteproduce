require 'yaml'
require 'logger'

namespace 'db' do
  desc "import icon"
  task(:import_icons => :environment) do
    import_icons
  end
end

def import_icons
  icons = YAML.load_file("lib/tasks/data/icons.yaml")
  result = []
  icons.each do |s|
    @icon = IconLibrary.where(
      :file_name =>  s['file_name'],
      :icon_type => s['icon_type']
    )
    if @icon.blank?
      IconLibrary.create(
        :file_name =>  s['file_name'],
        :icon_type => s['icon_type']
      )
    else
      next
    end
  end
end
