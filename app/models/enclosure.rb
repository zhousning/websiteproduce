# == Schema Information
#
# Table name: enclosures
#
#  id               :integer          not null, primary key
#  file             :string           default(""), not null
#  notice_id        :integer
#  website_id       :integer
#  page_id          :integer
#  block_content_id :integer
#  format_id        :integer
#  carousel_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Enclosure < ActiveRecord::Base
  belongs_to :notice

  belongs_to :notice
  belongs_to :article
  belongs_to :website
  belongs_to :page
  belongs_to :block_content
  belongs_to :format
  belongs_to :carousel
  belongs_to :ocr

  mount_uploader :file, EnclosureUploader
end
