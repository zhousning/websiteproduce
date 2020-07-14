class DraftMajor < ActiveRecord::Base
  belongs_to :medical_draft
  belongs_to :medical_major
end
