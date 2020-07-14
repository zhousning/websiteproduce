class CreateMedicalQuestions < ActiveRecord::Migration
  def change
    create_table :medical_questions do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.string :option,  null: false, default: Setting.systems.default_str
    
      t.string :answer,  null: false, default: Setting.systems.default_str
    
      t.text :analysis,  null: false, default: Setting.systems.default_str
      t.string :category,  null: false, default: Setting.systems.default_str
      t.string :qst_type,  null: false, default: Setting.systems.default_str
    

    
      t.references :medical_major
    

      t.timestamps null: false
    end
  end
end
