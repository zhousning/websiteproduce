# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  name        :string           default(""), not null
#  mastheader  :string           default(""), not null
#  block_order :string           default(""), not null
#  erb_file    :string           default(""), not null
#  parent_id   :integer
#  website_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Page < ActiveRecord::Base

  has_many :enclosures, :dependent => :destroy
  accepts_nested_attributes_for :enclosures, reject_if: :all_blank, allow_destroy: true


  has_many :blocks, :dependent => :destroy
  accepts_nested_attributes_for :blocks, reject_if: :all_blank, allow_destroy: true


  has_many :carousels, :dependent => :destroy
  accepts_nested_attributes_for :carousels, reject_if: :all_blank, allow_destroy: true


  belongs_to :website

  belongs_to :parent,  :class_name => 'Page'
  has_many :children,  :class_name => 'Page', :foreign_key => 'parent_id'

  def add_erb(erb)
    update_attribute :erb_file, erb
  end

  def add_mastheader(mastheader_id)
    update_attribute :mastheader, mastheader_id
  end

end
