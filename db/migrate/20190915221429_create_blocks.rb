class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.string :title_two,  null: false, default: Setting.systems.default_str

      t.string :block_layout,  null: false, default: Setting.block_layouts.four_column.value

      t.string :background,  null: false, default: Setting.systems.default_str

      t.string :color,  null: false, default: Setting.colors.dark.value
    
      t.string :subunit,  null: false, default: Setting.systems.default_str

      t.boolean :reset_icon, null: false, default: Setting.systems.status_en_no

      t.references :page
    
      t.references :layout
    

      t.references :title_one

      t.timestamps null: false
    end
  end
end
