class AddImageUrlToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :image_url, :string
  end
end
