class CreateArticleContents < ActiveRecord::Migration
  def change
    create_table :article_contents do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.text :desc,  null: false, default: Setting.systems.default_str
    
      t.string :tag,  null: false, default: Setting.systems.default_str
      t.references :article
    

    

      t.timestamps null: false
    end
  end
end
