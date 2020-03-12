# == Schema Information
#
# Table name: icon_libraries
#
#  id         :integer          not null, primary key
#  category   :string           default(""), not null
#  scene      :string           default(""), not null
#  style      :string           default(""), not null
#  file_name  :string           default(""), not null
#  tag        :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class IconLibrary < ActiveRecord::Base
  #searchkick

end
