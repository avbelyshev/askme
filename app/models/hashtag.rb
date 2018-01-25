class Hashtag < ApplicationRecord
  HASHTAG_REGEX = (/#[\p{L}0-9_]+/)

  has_and_belongs_to_many :questions

  validates :name, uniqueness: true

  def self.scan_string(text)
    text.scan(HASHTAG_REGEX).map { |tag| tag.mb_chars.downcase }.uniq
  end

  def self.from_string(text)
    tags_list = []
    scan_string(text).each { |tag| tags_list << find_or_create_by(name: tag) }
    tags_list
  end
end
