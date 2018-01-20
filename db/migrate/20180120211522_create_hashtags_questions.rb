class CreateHashtagsQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtags_questions, id: false do |t|
      t.references :hashtag, foreign_key: true
      t.references :question, foreign_key: true
    end
  end
end
