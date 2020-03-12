# == Schema Information
#
# Table name: selectors
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  category   :string           default("0"), not null
#  title      :string           default(""), not null
#  spider_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Selector < ActiveRecord::Base
  belongs_to :spider


end
