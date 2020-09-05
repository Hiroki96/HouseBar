class CreatePostCategoryRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :post_category_relationships do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps
    end
  end
end
