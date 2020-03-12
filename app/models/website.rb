# == Schema Information
#
# Table name: websites
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  navbar     :string           default(""), not null
#  mastheader :string           default(""), not null
#  footer     :string           default(""), not null
#  style      :string           default(""), not null
#  color      :string           default(""), not null
#  phone      :string           default(""), not null
#  wechat     :string           default(""), not null
#  address    :string           default(""), not null
#  email      :string           default(""), not null
#  qq         :string           default(""), not null
#  introduce  :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Website < ActiveRecord::Base

  mount_uploader :logo, EnclosureUploader

  has_many :pages, :dependent => :destroy
  accepts_nested_attributes_for :pages, reject_if: :all_blank, allow_destroy: true


  has_many :navbars, :dependent => :destroy
  accepts_nested_attributes_for :navbars, reject_if: :all_blank, allow_destroy: true

  has_many :documents, :dependent => :destroy

  belongs_to :user

  before_create :build_default_data
  def build_default_data
    index = Page.create(:name => '首页')
    self.pages << index 
  end

  def add_navbar(navbar_id)
    update_attribute :navbar, navbar_id
  end

  def add_footer(footer_id)
    update_attribute :footer, footer_id
  end

end
