class CreateUserGames < ActiveRecord::Migration[7.1]
  def change
    create_table :user_games do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.references :spell, null: false, foreign_key: true
      t.integer :score
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
