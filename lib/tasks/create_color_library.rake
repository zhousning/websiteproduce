require 'yaml'
require 'logger'
require 'find'

namespace 'db' do
  desc "init color"
  task(:create_color_library => :environment) do
    add_gradient_colors 
    add_pure_colors 
  end
end


def add_gradient_colors
  gradients = YAML.load_file('lib/tasks/data/gradient-color.yml')
  gradients.each do |obj|
    color_code = obj[1]['code']
    style_code = obj[1]['gradients']['code']
    style_colors = obj[1]['gradients']['value']
    style_colors.each do |val|
      color = ColorLibrary.where(:category => color_code, :style => style_code, :color_value => val)
      ColorLibrary.create(:category => color_code, :style => style_code, :color_value => val) if color.blank?
    end
  end
end

def add_pure_colors
  pures = YAML.load_file('lib/tasks/data/pure-color.yml')
  pures.each do |obj|
    color_code = obj[1]['code']
    style_code = obj[1]['pures']['code']
    style_colors = obj[1]['pures']['value']
    style_colors.each do |val|
      color = ColorLibrary.where(:category => color_code, :style => style_code, :color_value => val)
      ColorLibrary.create(:category => color_code, :style => style_code, :color_value => val) if color.blank?
    end
  end
end
