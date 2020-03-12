class CreateTitleThrees < ActiveRecord::Migration
  def change
    create_table :title_threes do |t|
    
      t.string :tag,  null: false, default: Setting.tags.p.value
    
      t.string :align,  null: false, default: Setting.aligns.justify.value
    
      t.string :color,  null: false, default: Setting.colors.dark.value
    
      t.string :font,  null: false, default: Setting.systems.default_str
    
      t.string :background,  null: false, default: Setting.systems.default_str
    
      t.string :weight,  null: false, default: Setting.systems.default_str
    
      t.string :line_height,  null: false, default: Setting.line_heights.height_36.value
    
      t.string :letter_spacing,  null: false, default: Setting.systems.default_str
    

    
      t.references :title_two
    

      t.timestamps null: false
    end
  end
end
