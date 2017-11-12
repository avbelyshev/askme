class Question < ApplicationRecord
  belongs_to :user
  has_one :author, class_name: 'User'

  validates :user, :text, presence: true
  validates :text, length: { maximum: 255 }

  def question_author
    User.find(author_id) unless author_id == nil
  end
end
