class MedicalMajor < ActiveRecord::Base

  has_many :draft_majors, :dependent => :destroy
  has_many :medical_drafts, :through => :draft_majors

  has_many :medical_questions, :dependent => :destroy
  accepts_nested_attributes_for :medical_questions, reject_if: :all_blank, allow_destroy: true


  belongs_to :medical_subject


end
