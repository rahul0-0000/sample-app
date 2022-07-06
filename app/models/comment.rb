class Comment < ApplicationRecord
  validates :user, presence: true
  validates :article, presence: true
  validates :comment, presence: true

  belongs_to :user
  belongs_to :article
end
