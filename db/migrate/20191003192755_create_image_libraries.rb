class CreateImageLibraries < ActiveRecord::Migration
  def change
    create_table :image_libraries do |t|
    
      t.string :category,  null: false, default: Setting.systems.default_str
    
      t.string :style,  null: false, default: Setting.systems.default_str
    
      t.string :file_name,  null: false, default: Setting.systems.default_str
      t.string :tag,  null: false, default: Setting.systems.default_str 
    
      t.float :width,  null: false, default: Setting.systems.default_num 
    
      t.float :height,  null: false, default: Setting.systems.default_num 
    
    

    

      t.timestamps null: false
    end
  end
end
