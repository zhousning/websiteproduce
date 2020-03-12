class CreateBlockContents < ActiveRecord::Migration
  def change
    create_table :block_contents do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
      t.string :file,  null: false, default: Setting.systems.default_str
      t.string :description,  null: false, default: Setting.systems.default_str

      t.string :tag,  null: false, default: Setting.systems.default_str

      t.text :area_icon,  null: false, default: Setting.systems.default_str

      t.text :line_icon,  null: false, default: Setting.systems.default_str

      t.text :image,  null: false, default: Setting.systems.default_str

      t.references :block

      t.timestamps null: false
    end
  end
end
