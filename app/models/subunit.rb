# == Schema Information
#
# Table name: subunits
#
#  id            :integer          not null, primary key
#  html          :text             default(""), not null
#  css           :text             default(""), not null
#  js            :text             default(""), not null
#  name          :string           default(""), not null
#  tag           :string           default(""), not null
#  category      :string           default("2"), not null
#  icon_category :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Subunit < ActiveRecord::Base

end
