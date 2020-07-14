class MedicalDraft < ActiveRecord::Base
  has_many :draft_majors, :dependent => :destroy
  has_many :medical_majors, :through => :draft_majors


end
