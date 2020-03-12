# == Schema Information
#
# Table name: navbars
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  website_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Navbar < ActiveRecord::Base


  has_many :menus, :dependent => :destroy
  accepts_nested_attributes_for :menus, reject_if: :all_blank, allow_destroy: true


  belongs_to :website


end
