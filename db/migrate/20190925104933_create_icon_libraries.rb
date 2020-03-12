class CreateIconLibraries < ActiveRecord::Migration
  def change
    create_table :icon_libraries do |t|
    
      t.string :category,  null: false, default: Setting.systems.default_str
    
      t.string :scene,  null: false, default: Setting.systems.default_str
    
      t.string :style,  null: false, default: Setting.systems.default_str
    
      t.string :file_name,  null: false, default: Setting.systems.default_str
    
      t.string :tag,  null: false, default: Setting.systems.default_str
    
      t.integer :icon_type,  null: false, default: Setting.icon_libraries.line_type
    

      t.timestamps null: false
    end
  end
end
