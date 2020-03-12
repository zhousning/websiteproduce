# == Schema Information
#
# Table name: title_ones
#
#  id             :integer          not null, primary key
#  tag            :string           default("2"), not null
#  align          :string           default("1"), not null
#  color          :string           default(""), not null
#  weight         :string           default(""), not null
#  font           :string           default("1"), not null
#  background     :string           default(""), not null
#  line_height    :string           default(""), not null
#  letter_spacing :string           default(""), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TitleOne < ActiveRecord::Base


  has_many :title_twos, :dependent => :destroy
  accepts_nested_attributes_for :title_twos, reject_if: :all_blank, allow_destroy: true


  has_many :blocks, :dependent => :destroy
  accepts_nested_attributes_for :blocks, reject_if: :all_blank, allow_destroy: true


end
