# == Schema Information
#
# Table name: image_libraries
#
#  id         :integer          not null, primary key
#  category   :string           default(""), not null
#  style      :string           default(""), not null
#  file_name  :string           default(""), not null
#  tag        :string           default(""), not null
#  width      :float            default(0.0), not null
#  height     :float            default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImageLibrary < ActiveRecord::Base
  #searchkick

end
