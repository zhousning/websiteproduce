class Block < ActiveRecord::Base


  has_many :block_contents, :dependent => :destroy
  accepts_nested_attributes_for :block_contents, reject_if: :all_blank, allow_destroy: true

  belongs_to :page

  belongs_to :title_one

  belongs_to :layout

  def add_subunit(subunit_id)
    update_attribute :subunit, subunit_id
  end


end
