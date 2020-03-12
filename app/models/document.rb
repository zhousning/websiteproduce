class Document < ActiveRecord::Base


  belongs_to :website

  validates :status, :presence => true,
                     :numericality => {:only_integer => true}

end
