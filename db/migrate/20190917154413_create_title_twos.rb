class CreateTitleTwos < ActiveRecord::Migration
  def change
    create_table :title_twos do |t|

      t.string :tag,  null: false, default: Setting.tags.h5.value
    
      t.string :align,  null: false, default: Setting.aligns.center.value
    
      t.string :color,  null: false, default: Setting.systems.default_str
    
      t.string :font,  null: false, default: Setting.fonts.title_two_font_30.value
    
      t.string :background,  null: false, default: Setting.systems.default_str
    
      t.string :weight,  null: false, default: Setting.systems.default_str
    
      t.string :line_height,  null: false, default: Setting.systems.default_str
    
      t.string :letter_spacing,  null: false, default: Setting.systems.default_str
    

    
      t.references :title_one
    

      t.timestamps null: false
    end
  end
end
