# == Schema Information
#
# Table name: title_threes
#
#  id             :integer          not null, primary key
#  tag            :string           default("7"), not null
#  align          :string           default("3"), not null
#  color          :string           default("9"), not null
#  font           :string           default(""), not null
#  background     :string           default(""), not null
#  weight         :string           default(""), not null
#  line_height    :string           default("36"), not null
#  letter_spacing :string           default(""), not null
#  title_two_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TitleThree < ActiveRecord::Base


  belongs_to :title_two


end
