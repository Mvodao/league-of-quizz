class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :category, null: false, foreign_key: true
      t.text :content
      t.string :question_type
      t.string :media_url

      t.timestamps
    end
  end
end
