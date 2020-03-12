class CreateNavbars < ActiveRecord::Migration
  def change
    create_table :navbars do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    

    
      t.references :website
    

      t.timestamps null: false
    end
  end
end
