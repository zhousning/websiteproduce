class CreateMedicalMajors < ActiveRecord::Migration
  def change
    create_table :medical_majors do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.string :total,  null: false, default: Setting.systems.default_str
    

    
      t.references :medical_subject
    

      t.timestamps null: false
    end
  end
end
