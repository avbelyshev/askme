class Question < ApplicationRecord
  belongs_to :user
  has_one :author, class_name: 'User'
  has_and_belongs_to_many :hashtags

  validates :user, :text, presence: true
  validates :text, length: { maximum: 255 }

  before_save :add_hashtags

  def question_author
    User.find(author_id) unless author_id == nil
  end

  def add_hashtags
    self.hashtags.clear
    tags_list = (text + answer).scan(/#[\p{L}0-9_]/).map(&:downcase).uniq
    tags_list.each do |tag|
      hashtag = Hashtag.find_or_create_by(name: tag)
      self.hashtags << hashtag
    end
  end
end
