class MedicalSubject < ActiveRecord::Base


  has_many :medical_majors, :dependent => :destroy
  accepts_nested_attributes_for :medical_majors, reject_if: :all_blank, allow_destroy: true


end
