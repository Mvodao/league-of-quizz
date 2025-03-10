class CreateQuestionsPools < ActiveRecord::Migration[7.1]
  def change
    create_table :questions_pools do |t|
      t.references :question, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
