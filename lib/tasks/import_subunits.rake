require 'yaml'
require 'logger'

namespace 'db' do
  desc "import subunit"
  task(:import_subunits => :environment) do
    init_import
  end
end

def init_import
  subunits = YAML.load_file("lib/tasks/data/subunits.yaml")
  result = []
  subunits.each do |s|
    @subunit = Subunit.where(
      :html =>  s['html'],
      :css => s['css'],
      :js => s['js'],
      :name =>  s['name'],
      :tag => s['tag'],
      :category => s['category'],
      :icon_category => s['icon_category'],
      :min_length => s['min_length'],
      :max_length => s['max_length']
    )
    if @subunit.blank?
      Subunit.create(
        :html =>  s['html'],
        :css => s['css'],
        :js => s['js'],
        :name =>  s['name'],
        :tag => s['tag'],
        :category => s['category'],
        :icon_category => s['icon_category'],
        :min_length => s['min_length'],
        :max_length => s['max_length']
      )
    else
      next
    end
  end
end
