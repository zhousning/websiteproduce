class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.string :file,  null: false, default: Setting.systems.default_str
    
      t.references :page

      t.timestamps null: false
    end
  end
end
