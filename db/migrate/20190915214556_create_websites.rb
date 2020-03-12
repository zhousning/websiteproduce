class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
      t.string :logo,  null: false, default: ""

      t.string :navbar,  null: false, default: Setting.systems.default_str
    
      t.string :mastheader,  null: false, default: Setting.systems.default_str

      t.string :footer,  null: false, default: Setting.systems.default_str

      t.string :style,  null: false, default: Setting.systems.default_str
    
      t.string :color,  null: false, default: Setting.systems.default_str
    
      t.string :phone,  null: false, default: Setting.systems.default_str
    
      t.string :wechat,  null: false, default: Setting.systems.default_str
    
      t.string :address,  null: false, default: Setting.systems.default_str
    
      t.string :email,  null: false, default: Setting.systems.default_str
    
      t.string :qq,  null: false, default: Setting.systems.default_str
    
      t.string :introduce,  null: false, default: Setting.systems.default_str
    
      t.references :user

      t.timestamps null: false
    end
  end
end
