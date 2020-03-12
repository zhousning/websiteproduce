class CreateSubunits < ActiveRecord::Migration
  def change
    create_table :subunits do |t|
    
      t.text :html,  null: false, default: Setting.systems.default_str
    
      t.text :css,  null: false, default: Setting.systems.default_str
    
      t.text :js,  null: false, default: Setting.systems.default_str
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.string :tag,  null: false, default: Setting.systems.default_str

      t.string :category,  null: false, default: Setting.subunit_types.section.value

      t.string :icon_category,  null: false, default: Setting.systems.default_str

      t.integer :min_length, null:false, default: Setting.systems.default_num

      t.integer :max_length, null:false, default: Setting.systems.default_num

      t.timestamps null: false
    end
  end
end
