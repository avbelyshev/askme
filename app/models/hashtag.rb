class Hashtag < ApplicationRecord
  has_and_belongs_to_many :questions

  validates :name, uniqueness: true
end
