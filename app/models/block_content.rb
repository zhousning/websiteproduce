class BlockContent < ActiveRecord::Base

  mount_uploader :file, EnclosureUploader

  belongs_to :block

  def add_tag(tag)
    update_attribute :tag, tag
  end

  def add_icon(line_icon, area_icon)
    update_attributes :line_icon => line_icon, :area_icon => area_icon
  end

  def add_image(image)
    update_attribute :image, image
  end
end
