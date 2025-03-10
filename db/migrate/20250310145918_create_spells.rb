class CreateSpells < ActiveRecord::Migration[7.1]
  def change
    create_table :spells do |t|
      t.string :name
      t.string :image_url
      t.text :description

      t.timestamps
    end
  end
end
