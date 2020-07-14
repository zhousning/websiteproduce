class CreateDraftMajors < ActiveRecord::Migration
  def change
    create_table :draft_majors do |t|
      t.integer :medical_draft_id
      t.integer :medical_major_id
      t.integer :total

      t.timestamps null: false
    end
  end
end
