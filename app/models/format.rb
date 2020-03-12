# == Schema Information
#
# Table name: formats
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Format < ActiveRecord::Base

  has_many :enclosures, :dependent => :destroy
  accepts_nested_attributes_for :enclosures, reject_if: :all_blank, allow_destroy: true


  has_many :blocks, :dependent => :destroy
  accepts_nested_attributes_for :blocks, reject_if: :all_blank, allow_destroy: true


end
