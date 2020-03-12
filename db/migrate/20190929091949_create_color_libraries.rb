class CreateColorLibraries < ActiveRecord::Migration
  def change
    create_table :color_libraries do |t|
    
      t.string :category,  null: false, default: Setting.systems.default_str
    
      t.string :style,  null: false, default: Setting.systems.default_str
    
      t.string :color_value,  null: false, default: Setting.systems.default_str
    
      t.string :tag,  null: false, default: Setting.systems.default_str
    

    

      t.timestamps null: false
    end
  end
end
