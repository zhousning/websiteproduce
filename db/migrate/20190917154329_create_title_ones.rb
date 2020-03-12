class CreateTitleOnes < ActiveRecord::Migration
  def change
    create_table :title_ones do |t|
    
      t.string :tag,  null: false, default: Setting.tags.h2.value
    
      t.string :align,  null: false, default: Setting.aligns.center.value
    
      t.string :color,  null: false, default: Setting.systems.default_str
    
      t.string :weight,  null: false, default: Setting.systems.default_str
    
      t.string :font,  null: false, default: Setting.fonts.title_one_font_45.value
    
      t.string :background,  null: false, default: Setting.systems.default_str
    
      t.string :line_height,  null: false, default: Setting.systems.default_str
    
      t.string :letter_spacing,  null: false, default: Setting.systems.default_str
    

    

      t.timestamps null: false
    end
  end
end
