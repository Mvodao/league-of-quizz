class AddUserReferencesToQuestionsPools < ActiveRecord::Migration[7.1]
  def change
    add_reference :questions_pools, :user, null: true, foreign_key: true
  end
end
