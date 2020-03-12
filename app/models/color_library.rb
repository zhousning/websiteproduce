# == Schema Information
#
# Table name: color_libraries
#
#  id          :integer          not null, primary key
#  category    :string           default(""), not null
#  style       :string           default(""), not null
#  color_value :string           default(""), not null
#  tag         :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ColorLibrary < ActiveRecord::Base


end
