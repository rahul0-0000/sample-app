class Article < ApplicationRecord
  validates :author, presence: true

  # associations
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
end
