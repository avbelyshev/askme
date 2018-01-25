class Question < ApplicationRecord
  belongs_to :user
  has_one :author, class_name: 'User'
  has_and_belongs_to_many :hashtags

  validates :user, :text, presence: true
  validates :text, length: { maximum: 255 }

  before_save :add_hashtags

  def question_author
    User.find_by(id: author_id)
  end

  def add_hashtags
    self.hashtags.clear
    tags_list = Hashtag.from_string("#{text}#{answer}")
    tags_list.each { |tag| self.hashtags << tag }
  end
end
