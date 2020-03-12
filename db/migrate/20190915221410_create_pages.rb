class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str

      t.text :draft,  null: false, default: Setting.systems.default_str

      t.text :keyword,  null: false, default: Setting.systems.default_str

      t.string :mastheader,  null: false, default: Setting.systems.default_str
    
      t.string :block_order,  null: false, default: Setting.systems.default_str
    
      t.string :erb_file,  null: false, default: Setting.systems.default_str

      t.integer :parent_id
    
      t.references :website

      t.timestamps null: false
    end
  end
end
