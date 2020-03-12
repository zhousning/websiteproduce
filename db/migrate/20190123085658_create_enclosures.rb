class CreateEnclosures < ActiveRecord::Migration
  def change
    create_table :enclosures do |t|
      t.string :file,  null: false, default: ""

      t.references :notice
      t.references :article
      t.references :page
      t.references :format
      t.references :ocr

      t.timestamps null: false
    end
  end
end
