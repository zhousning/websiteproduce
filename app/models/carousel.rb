# == Schema Information
#
# Table name: carousels
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  page_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Carousel < ActiveRecord::Base

  mount_uploader :file, EnclosureUploader

  belongs_to :page


end
