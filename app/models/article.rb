class Article < ActiveRecord::Base

  has_many :enclosures, :dependent => :destroy
  accepts_nested_attributes_for :enclosures, reject_if: :all_blank, allow_destroy: true


  has_many :article_contents, :dependent => :destroy
  accepts_nested_attributes_for :article_contents, reject_if: :all_blank, allow_destroy: true


end
