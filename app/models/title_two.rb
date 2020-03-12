# == Schema Information
#
# Table name: title_twos
#
#  id             :integer          not null, primary key
#  tag            :string           default("5"), not null
#  align          :string           default("1"), not null
#  color          :string           default(""), not null
#  font           :string           default("2"), not null
#  background     :string           default(""), not null
#  weight         :string           default(""), not null
#  line_height    :string           default(""), not null
#  letter_spacing :string           default(""), not null
#  title_one_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TitleTwo < ActiveRecord::Base


  has_many :title_threes, :dependent => :destroy
  accepts_nested_attributes_for :title_threes, reject_if: :all_blank, allow_destroy: true


  belongs_to :title_one


end
